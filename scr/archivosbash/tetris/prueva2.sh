#!/bin/bash

# Definición de las piezas de Tetris
declare -A O_piece=(
    [0,0]=1 [0,1]=1 [0,2]=0 [0,3]=0
    [1,0]=1 [1,1]=1 [1,2]=0 [1,3]=0
    [2,0]=0 [2,1]=0 [2,2]=0 [2,3]=0
    [3,0]=0 [3,1]=0 [3,2]=0 [3,3]=0
)

MOVE="\033[%d;%dH"

function draw_piece() {
    local piece=$1
    local x=$2
    local y=$3
    local -n matrix=$piece
    
    for i in {0..3}; do
        for j in {0..3}; do
            if [ ${matrix[$i,$j]} -eq 1 ]; then
                printf "$MOVE" $((x + i)) $((y + j))
                echo -n "#"
            fi
        done
    done

    echo -e "\033[0m"  # Reset terminal formatting
}

# Llamar a la función para dibujar la pieza
draw_piece O_piece 6 5