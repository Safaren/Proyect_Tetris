#!/bin/bash

# Crear la matriz bidimensional como un array asociativo
declare -A matriz

# Inicializar la matriz con valores específicos
matriz[0,0]=3
matriz[0,1]=4
matriz[1,0]=4
matriz[1,1]=7

# Dimensiones de la matriz
rows=2
cols=2

# Función para imprimir la matriz
print_matrix() {
    for i in $(seq 0 $((rows - 1))); do
        for j in $(seq 0 $((cols - 1))); do
            echo -n "${matriz[$i,$j]} "
        done
        echo
    done
}

# Imprimir la matriz
print_matrix