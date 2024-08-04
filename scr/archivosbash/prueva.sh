#!/bin/bash

# Dimensiones del tablero
HEIGHT=20
WIDTH=10

# Secuencias ASCII para controlar el cursor
HIDECURSOR="\033[?25l"
SHOWCURSOR="\033[?25h"
CLEARSCREEN="\033[2J"
GOTO="\033[%d;%dH"

# Función para ocultar el cursor
hide_cursor() {
    echo -ne "$HIDECURSOR"
}

# Función para mostrar el cursor
show_cursor() {
    echo -ne "$SHOWCURSOR"
}

# Función para mover el cursor a una posición específica
move_cursor() {
    local row=$1
    local col=$2
    printf "$GOTO" "$row" "$col"
}

# Función para obtener las coordenadas de una pieza en una rotación específica
get_piece_coordinates() {
    local piece=("${!1}")
    local rotation=$2
    echo "${piece[$rotation]}"
}

# Función para dibujar el tablero
draw_board() {
    clear
    for ((y = 0; y < HEIGHT; y++)); do
        for ((x = 0; x < WIDTH; x++)); do
            if [[ ${board[$x,$y]} == "▓" ]]; then
                echo -ne "▓"
            else
                echo -ne " "
            fi
        done
        echo
    done
}

# Inicializar el tablero con espacios
declare -A board
for ((y = 0; y < HEIGHT; y++)); do
    for ((x = 0; x < WIDTH; x++)); do
        board[$x,$y]=" "
    done
done

# Función para colocar una pieza en el tablero
place_piece() {
    local x_offset=$1
    local y_offset=$2
    shift 2
    local piece_coords=("$@")
    for coord in "${piece_coords[@]}"; do
        IFS=',' read -r x y <<< "$coord"
        board[$((x + x_offset)),$((y + y_offset))]="▓"
    done
}

# Función para dibujar la pieza en la terminal
draw_piece() {
    local x_offset=$1
    local y_offset=$2
    shift 2
    local piece_coords=("$@")
    for coord in "${piece_coords[@]}"; do
        IFS=',' read -r x y <<< "$coord"
        move_cursor $((y + y_offset + 1)) $((x + x_offset + 1))
        echo -ne "▓"
    done
}

# Ocultar el cursor
hide_cursor
clear

# Obtener las coordenadas de la pieza 'I' en rotación 0 y colocarla en el tablero
piece_coords=$(get_piece_coordinates piece_I[@] 0)
place_piece 3 5 $piece_coords
draw_piece 3 5 $piece_coords

# Restaurar el cursor al final
show_cursor

# Esperar a que el usuario presione una tecla para salir
read -n1 -s
