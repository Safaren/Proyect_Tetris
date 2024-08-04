#!/bin/bash

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

# Agrupar todas las piezas en un array principal
pieces=(
    "${piece_I[@]}"
    "${piece_O[@]}"
    "${piece_T[@]}"
)

# Función para mostrar una pieza en una rotación específica
show_piece() {
    local piece=("${!1}")  # Expande el array pasado como argumento
    local rotation=$2
    local rotation_positions=${piece[$rotation]}
    
    echo "Pieza en rotación $rotation: $rotation_positions"
}

# Mostrar la pieza 'I' en rotación 0
show_piece piece_I[@] 0

# Mostrar la pieza 'O' en rotación 0
show_piece piece_O[@] 0

# Mostrar la pieza 'T' en rotación 2
show_piece piece_T[@] 2

# La estructura de piezas puede ser iterada y utilizada según sea necesario
for piece in "${pieces[@]}"; do
    echo "Pieza: $piece"
done