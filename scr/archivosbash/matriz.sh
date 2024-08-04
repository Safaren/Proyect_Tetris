#!/bin/bash

# Dimensiones de la matriz
width=20
height=36

# Crear la matriz
declare -A matrix

# Inicializar la matriz con valores
for ((i=0; i<height; i++)); do
    for ((j=0; j<width; j++)); do
        matrix[$i,$j]=0
    done
done

# Función para imprimir la matriz
print_matrix() {
    for ((i=0; i<height; i++)); do
        for ((j=0; j<width; j++)); do
            echo -n "${matrix[$i,$j]} "
        done
        echo
    done
}

# Ejemplo de uso: establecer un valor en una posición específica
matrix[1,2]=5
matrix[10,10]=8

# Imprimir la matriz
print_matrix