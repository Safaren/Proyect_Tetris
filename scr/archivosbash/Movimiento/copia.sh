#!/bin/bash

WIDTH=20
ym=2
xm=5 #$((WIDTH / 2))
MOVE="\033[%d;%dH"

pieces_value=(
    "1,1,1,1,1,1,9,0,0,1,1,0,0" # piece_T
    "1,1,1,1,9,1,1,1,1"
    "1,1,9,1,1,9,1,1,9,1,1"
    "1,1,1,1,0,0,0,0,9,0,0,0,0,1,1,1,1"
)

pieces_te=()

generate_pieces() {
    local -n pieces=$1
    local -n values=$2

    local x y value
    local y_inc=0

    for row in "${values[@]}"; do
        local x_inc=0

        IFS=',' read -ra row_values <<< "$row"
        for value in "${row_values[@]}"; do
            if [ "$value" -eq 9 ]; then 
                y_inc=$((y_inc + 1))
                x_inc=0
            else 
                x=$((xm + x_inc))
                y=$((ym + y_inc))
                pieces+=("${x},${y},${value}")
                x_inc=$((x_inc + 1))
            fi
        done
    done
}

generate_pieces pieces_te pieces_value

echo "Debug: Contenido de pieces_te:"
for i in "${!pieces_te[@]}"; do
    echo "${pieces_te[$i]}"
done

draw_piece() {
    local elemento=$1

    IFS=',' read -r x y dibujar <<< "$elemento"

    x=$((x))
    y=$((y))

    echo "Coordenadas: ($x, $y), Dibujar: $dibujar"
}

for i in "${!pieces_te[@]}"; do
    draw_piece "${pieces_te[$i]}"
done
