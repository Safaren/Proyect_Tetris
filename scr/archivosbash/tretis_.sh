#!/bin/bash 

stty -echo # evita que se escriban caracteres
stty -icanon # evita qeu se tenga que puldar enter para enviar el caracter

# Gruardado de las piezas en un array de piezas, cada pieza es un array de caractreres
#pieces

# Piezas

# Tablero

  #Dimensiones del tablero
  HEIGHT=30
  WIDTH=30

# Inicializar el tablero con espacios y borde

declare -A board

<<'COMENTARIOS'
for ((y=0; y <HEIGHT; y++)); do
  for ((x=0; x < WIDTH; x++)); do
  if [[ ($x -eq 0  || $x -eq $((WIDTH-1)))  && ($y -gt 0 && $y -lt $((HEIGHT-1))) ]]; then
    board[$x,$y]='║'
  elif [[ ($y -eq 0 || $y -eq $(($HEIGHT-1))) && ($x -gt 0 && $x -lt $((WIDTH-1))) ]] ; then
    board[$x,$y]='═'
  elif [[ ($x -eq 0 && $y -eq 0) ]]; then
   board[$x,$y]='╔'
  elif [[ ($x -eq 0 && $y -eq $(($HEIGHT-1))) ]]; then
   board[$x,$y]='╚'
  else

   board[$x,$y]=' '

   
   fi
  done
done
COMENTARIOS

# Definir caracteres para los bordes y esquinas
CHAR_VERTICAL='║'
CHAR_HORIZONTAL='═'
CHAR_TOP_LEFT='╔'
CHAR_BOTTOM_LEFT='╚'
CHAR_TOP_RIGHT='╗'
CHAR_BOTTOM_RIGHT='╝'
CHAR_EMPTY=" "

# Secuencias ASCII
HIDECURSOR="\033[?25l"
RESTORECURSOR="\033[?25h"
GOTO="\033[%d;%dH"

# Defunición de piezas

piece_I=(
    "10,1 10,2 10,3 10,4 10,5"
    "8,3 9,3 10,3 11,3 11,3"
    "10,1 10,2 10,3 10,4 10,5"
    "8,3 9,3 10,3 11,3 11,3"
)


hide_cursor() {
    echo -ne "$HIDECURSOR"
}

show_cursor() {
    echo -ne "$RESTORECURSOR"
    stty echo # evita que se escriban caracteres
    stty icanon
}




get_char() {
  local x=$1
  local y=$2
 if [[ ($x -eq 0  || $x -eq $((WIDTH-1)))  && ($y -gt 0 && $y -lt $((HEIGHT-1))) ]]; then
    echo "$CHAR_VERTICAL"
  elif [[ ($y -eq 0 || $y -eq $(($HEIGHT-1))) && ($x -gt 0 && $x -lt $((WIDTH-1))) ]] ; then
    echo "$CHAR_HORIZONTAL"
  else
     case "$x,$y" in
    "0,0")
      echo "$CHAR_TOP_LEFT"
      ;;
    "0,$((HEIGHT - 1))")
      echo "$CHAR_BOTTOM_LEFT"
      ;;
    "$((WIDTH - 1)),0")
      echo "$CHAR_TOP_RIGHT"
      ;;
    "$((WIDTH - 1)),$((HEIGHT - 1))")
      echo "$CHAR_BOTTOM_RIGHT"
      ;;
      *)
      echo " "
      ;;
  esac
   fi
}



# Función para inicializar el tablero con bordes y espacios
initialize_board() {
  for ((y=0; y < HEIGHT; y++)); do
    for ((x=0; x < WIDTH; x++)); do
      board[$x,$y]=$(get_char $x $y)
    done
  done
}

# Función para mostrar el tablero
print_board() {
  for ((y=0; y < HEIGHT; y++)); do
    for ((x=0; x < WIDTH; x++)); do
      echo -n "${board[$x,$y]}"
    done
    echo
  done
}

# Función que obtiene las coordenadas de la pieza

get_piece_coordinates() {
    local piece=("${!1}")
    local rotation=$2
    echo "${piece[$rotation]}"
}

# Función para dibujar la pieza en la terminal
draw_piece() {
    local x_offset=$1
    local y_offset=$2
    shift 2
    local piece_coords=("$@")
    for coord in "${piece_coords[@]}"; do
        IFS=',' read -r x y <<< "$coord"
        move_pieces $((x + x_offset + 1)) $((y + y_offset + 1))
        board[$((x + x_offset)),$((y + y_offset))]="▓"
        #echo -ne "▓"
    done
}

# Función para guardar las piezas en un array


# Función de movimiento

move_pieces() {

local row=$1
local col=$2
printf "$GOTO" "$row" "$col"

}
clear_piece() {
    local x_offset=$1
    local y_offset=$2
    shift 2
    local piece_coords=("$@")
    for coord in "${piece_coords[@]}"; do
        IFS=',' read -r x y <<< "$coord"
        board[$((x + x_offset)),$((y + y_offset))]=$CHAR_EMPTY
        # echo -ne "perro"
    done
}


handle_input() {
    local key=$1
    case $key in
        "a") # Mover a la izquierda
            if [[ $x_offset -gt 0 ]]; then
                clear_piece $x_offset $y_offset "${piece_coords[@]}"
                x_offset=$((x_offset - 1))
                draw_piece $x_offset $y_offset "${piece_coords[@]}"
            fi
            ;;
        "d") # Mover a la derecha
            if [[ $((x_offset + 1)) -lt $WIDTH ]]; then
                clear_piece $x_offset $y_offset "${piece_coords[@]}"
                x_offset=$((x_offset + 1))
                draw_piece $x_offset $y_offset "${piece_coords[@]}"
            fi
            ;;
        "s") # Mover hacia abajo
            if [[ $((y_offset + 1)) -lt $HEIGHT ]]; then
                clear_piece $x_offset $y_offset "${piece_coords[@]}"
                y_offset=$((y_offset + 1))
                draw_piece $x_offset $y_offset "${piece_coords[@]}"
            fi
            ;;
        "w") # Rotar la pieza
            rotation=$(( (rotation + 1) % 4 ))
            #clear_piece $x_offset $y_offset "${piece_coords[@]}"
            piece_coords=$(get_piece_coordinates piece_I[@] $rotation)
            draw_piece $x_offset $y_offset "${piece_coords[@]}"
            ;;
    esac
}


#MAIN
clear
hide_cursor
initialize_board
print_board

while true; do
    read -t 0.1 -n1 key
    handle_input $key

    clear_piece $x_offset $y_offset "${piece_coords[@]}"
    y_offset=$((y_offset + 1))
    piece_coords=$(get_piece_coordinates piece_I[@] $rotation)
    draw_piece $x_offset $y_offset $piece_coords

    sleep 0.5
done

piece_coords=$(get_piece_coordinates piece_I[@] 0)



#read -n1

trap 'show_cursor' EXIT




# Defenición de teclas de movimiento

# Borrado de las filas al estar completas

# Mostrar puntuación

# Mostrar tablero

# Variables de nivel y velocidad

# Función de cálculo de puntaje

