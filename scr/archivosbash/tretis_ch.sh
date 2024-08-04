#!/bin/bash

# Configuración del tablero
WIDTH=10
HEIGHT=20

# Inicializar el tablero
declare -A board
for ((y=0; y<HEIGHT; y++)); do
    for ((x=0; x<WIDTH; x++)); do
        board[$x,$y]=' '
    done
done

# Piezas de Tetris
declare -A piece_I
piece_I[0,0]='I'
piece_I[1,0]='I'
piece_I[2,0]='I'
piece_I[3,0]='I'

# Función para mostrar el tablero
function draw_board {
    clear
    for ((y=0; y<HEIGHT; y++)); do
        for ((x=0; x<WIDTH; x++)); do
            echo -n "${board[$x,$y]}"
        done
        echo
    done
}

# Función para dibujar una pieza
function draw_piece {
    local -n piece=$1
    local offset_x=$2
    local offset_y=$3
    
    for ((y=0; y<4; y++)); do
        for ((x=0; x<4; x++)); do
            if [[ ${piece[$x,$y]} != '' ]]; then
                board[$((x + offset_x)),$((y + offset_y))]=${piece[$x,$y]}
            fi
        done
    done
}

# Función para leer una tecla
function read_key {
    read -s -n 1 key
}

# Función para mover la pieza hacia abajo
function move_down {
    offset_y=$((offset_y + 1))
    draw_piece piece_I $offset_x $offset_y
    draw_board
}

# Bucle principal del juego
offset_x=3
offset_y=0

while true; do
    read_key
    case $key in
        s) move_down ;;
    esac
done