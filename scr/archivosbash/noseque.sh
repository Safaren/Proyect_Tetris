#!/bin/bash

stty -echo -icanon  # Configura el terminal para no mostrar caracteres y no requerir Enter

# Dimensiones del tablero
HEIGHT=30
WIDTH=30

# Inicializar el tablero con espacios
declare -A board

# Definir caracteres para los bordes y esquinas
CHAR_VERTICAL='║'
CHAR_HORIZONTAL='═'
CHAR_TOP_LEFT='╔'
CHAR_BOTTOM_LEFT='╚'
CHAR_TOP_RIGHT='╗'
CHAR_BOTTOM_RIGHT='╝'
CHAR_EMPTY=' '

# Secuencias ASCII
HIDECURSOR="\033[?25l"
SHOWCURSOR="\033[?25h"
GOTO="\033[%d;%dH"

# Definición de piezas
piece_I=(
    "10,1 10,2 10,3 10,4"  # Rotación 0
    "8,3 9,3 10,3 11,3"   # Rotación 1
    "10,1 10,2 10,3 10,4" # Rotación 2
    "8,3 9,3 10,3 11,3"   # Rotación 3
)

hide_cursor() {
    echo -ne "$HIDECURSOR"
}

show_cursor() {
    echo -ne "$SHOWCURSOR"
    stty echo icanon  # Restaura la configuración del terminal
}

move_cursor() {
    local row=$1
    local col=$2
    printf "$GOTO" "$row" "$col"
}

get_char() {
    local x=$1
    local y=$2
    if [[ $x -eq 0 || $x -eq $((WIDTH-1)) && $y -gt 0 && $y -lt $((HEIGHT-1)) ]]; then
        echo "$CHAR_VERTICAL"
    elif [[ $y -eq 0 || $y -eq $((HEIGHT-1)) && $x -gt 0 && $x -lt $((WIDTH-1)) ]]; then
        echo "$CHAR_HORIZONTAL"
    else
        case "$x,$y" in
            "0,0") echo "$CHAR_TOP_LEFT" ;;
            "0,$((HEIGHT - 1))") echo "$CHAR_BOTTOM_LEFT" ;;
            "$((WIDTH - 1)),0") echo "$CHAR_TOP_RIGHT" ;;
            "$((WIDTH - 1)),$((HEIGHT - 1))") echo "$CHAR_BOTTOM_RIGHT" ;;
            *) echo "$CHAR_EMPTY" ;;
        esac
    fi
}

initialize_board() {
    for ((y=0; y < HEIGHT; y++)); do
        for ((x=0; x < WIDTH; x++)); do
            board[$x,$y]=$(get_char $x $y)
        done
    done
}

print_board() {
    clear
    for ((y=0; y < HEIGHT; y++)); do
        for ((x=0; x < WIDTH; x++)); do
            move_cursor $((y + 1)) $((x + 1))
            echo -n "${board[$x,$y]}"
        done
        echo
    done
}

get_piece_coordinates() {
    local piece=("${!1}")
    local rotation=$2
    echo "${piece[$rotation]}"
}

draw_piece() {
    local x_offset=$1
    local y_offset=$2
    shift 2
    local piece_coords=("$@")
    for coord in "${piece_coords[@]}"; do
        IFS=',' read -r x y <<< "$coord"
        board[$((x + x_offset)),$((y + y_offset))]="▓"
        move_cursor $((y + y_offset + 1)) $((x + x_offset + 1))
        echo -n "▓"
    done
}

clear_piece() {
    local x_offset=$1
    local y_offset=$2
    shift 2
    local piece_coords=("$@")
    for coord in "${piece_coords[@]}"; do
        IFS=',' read -r x y <<< "$coord"
        board[$((x + x_offset)),$((y + y_offset))]=$CHAR_EMPTY
        move_cursor $((y + y_offset + 1)) $((x + x_offset + 1))
        echo -n "$CHAR_EMPTY"
    done
}

handle_input() {
    local key=$1
    case $key in
        "a") # Mover a la izquierda
            if [[ $x_offset -gt 0 ]]; then
                clear_piece $x_offset $y_offset "${piece_coords[@]}"
                x_offset=$((x_offset - 1))
                piece_coords=($(get_piece_coordinates piece_I[@] $rotation))
                draw_piece $x_offset $y_offset "${piece_coords[@]}"
            fi
            ;;
        "d") # Mover a la derecha
            if [[ $((x_offset + 1)) -lt $WIDTH ]]; then
                clear_piece $x_offset $y_offset "${piece_coords[@]}"
                x_offset=$((x_offset + 1))
                piece_coords=($(get_piece_coordinates piece_I[@] $rotation))
                draw_piece $x_offset $y_offset "${piece_coords[@]}"
            fi
            ;;
        "s") # Mover hacia abajo
            if [[ $((y_offset + 1)) -lt $HEIGHT ]]; then
                clear_piece $x_offset $y_offset "${piece_coords[@]}"
                y_offset=$((y_offset + 1))
                piece_coords=($(get_piece_coordinates piece_I[@] $rotation))
                draw_piece $x_offset $y_offset "${piece_coords[@]}"
            fi
            ;;
        "w") # Rotar la pieza
            rotation=$(( (rotation + 1) % 4 ))
            clear_piece $x_offset $y_offset "${piece_coords[@]}"
            piece_coords=($(get_piece_coordinates piece_I[@] $rotation))
            draw_piece $x_offset $y_offset "${piece_coords[@]}"
            ;;
    esac
}

# MAIN
clear
hide_cursor
initialize_board
print_board

x_offset=4
y_offset=0
rotation=0
piece_coords=($(get_piece_coordinates piece_I[@] $rotation))
draw_piece $x_offset $y_offset "${piece_coords[@]}"

while true; do
    read -t 0.1 -n1 key
    handle_input $key

    clear_piece $x_offset $y_offset "${piece_coords[@]}"
    y_offset=$((y_offset + 1))
    
    # Verificar si la pieza ha llegado al final
    if [[ $((y_offset + 1)) -ge $HEIGHT || ${board[$x_offset,$((y_offset + 1))]} == "▓" ]]; then
        y_offset=$((y_offset - 1))  # Revertir el movimiento
        piece_coords=($(get_piece_coordinates piece_I[@] $rotation))
        draw_piece $x_offset $y_offset "${piece_coords[@]}"
        # Reiniciar la pieza (esto puede ser reemplazado con lógica de nuevas piezas)
        x_offset=4
        y_offset=0
        rotation=0
        piece_coords=($(get_piece_coordinates piece_I[@] $rotation))
        draw_piece $x_offset $y_offset "${piece_coords[@]}"
    else
        piece_coords=($(get_piece_coordinates piece_I[@] $rotation))
        draw_piece $x_offset $y_offset "${piece_coords[@]}"
    fi

    sleep 0.5
done

trap 'show_cursor' EXIT
