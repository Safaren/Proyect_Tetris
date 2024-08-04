#!/bin/bash

# Función para ocultar el cursor
hide_cursor() {
    echo -ne "\033[?25l"
}

# Función para mostrar el cursor
show_cursor() {
    echo -ne "\033[?25h"
}

# Función para mover el cursor a una posición específica
move_cursor() {
    local row=$1
    local col=$2
    echo -ne "\033[${row};${col}H"
}

# Función para limpiar la pantalla
clear_screen() {
    echo -ne "\033[2J"
}

# Ocultar el cursor y limpiar la pantalla
hide_cursor
clear_screen

# Posición inicial
row=10
col=10

# Dibujar el carácter en la posición inicial
move_cursor $row $col
echo -n "▓"

# Esperar un segundo
sleep 1

# Mover el carácter hacia abajo
for ((i = 0; i < 10; i++)); do
    # Limpiar la posición anterior
    move_cursor $row $col
    echo -n " "
    
    # Actualizar la posición
    ((row++))
    
    # Dibujar el carácter en la nueva posición
    move_cursor $row $col
    echo -n "▓"
    
    # Esperar un poco antes de mover de nuevo
    sleep 0.1
done

# Restaurar el cursor
show_cursor

# Esperar a que el usuario presione una tecla para salir
read -n1 -s
