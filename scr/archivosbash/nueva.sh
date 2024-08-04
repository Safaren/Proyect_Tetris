#!/bin/bash

# Dimensiones del tablero
HEIGHT=20
WIDTH=10

# Definir las piezas con sus rotaciones
piece_I=(
    "0,1 1,1 2,1 3,1"  # Rotación 0
    "2,0 2,1 2,2 2,3"  # Rotación 1
    "0,2 1,2 2,2 3,2"  # Rotación 2
    "1,0 1,1 1,2 1,3"  # Rotación 3
)

piece_O=(
    "1,1 1,2 2,1 2,2"  # Rotación 0 (la única rotación)
)

piece_T=(
    "1,0 0,1 1,1 2,1"  # Rotación 0
    "1,0 1,1 2,1 1,2"  # Rotación 1
    "0,1 1,1 2,1 1,2"  # Rotación 2
    "1,0 0,1 1,1 1,2"  # Rotación 3
)

# Función para ocultar el cursor
hide_cursor() {
    echo -ne "\033[?25l"
}

# Función para mostrar el cursor
show_cursor() {
    echo -ne "\033[?25h"
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
    local piece_coords=("$@")
    for coord in "${piece_coords[@]}"; do
        IFS=',' read -r x y <<< "$coord"
        board[$x,$y]="▓"
    done
}

# Ejemplo de uso para colocar y dibujar una pieza
hide_cursor

# Obtener las coordenadas de la pieza 'I' en rotación 0 y colocarla en el tablero
piece_coords=$(get_piece_coordinates piece_I[@] 0)
place_piece $piece_coords

# Dibujar el tablero con la pieza
draw_board

# Restaurar el cursor al final
show_cursor

# Esperar a que el usuario presione una tecla para salir
read -n1 -s
