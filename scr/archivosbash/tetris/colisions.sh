#!/bin/bash

#librery
source ./board.sh
source ./pieces.sh
source ./variables.sh



# Funcion para comprobar se a chocado 

    check_collision() {
        
    
        printf "\033[0;0H" 
        echo -n "$xm $ym ${board[$xm,$ym]}"; 
        if [[ ${board[$xm,$ym]} -eq 1 ]]; then
        reset_piece
        fi
}

clear_piece() {
    local piece=$1;
    local x=$3;
    local y=$2;
    ##local MOVE=$4;
    local -n matrix=$piece
    
    for i in {0..3}; do
        for j in {0..1}; do
            printf "$MOVE" $((x + j)) $((y + i)) #echo -n "${matrix[$i,$j]} "
            echo -n " ";
        done
        echo
    done

    #Añadir a la matriz cada casilla con sus coordenadas y si vale 0 o 1
    # Al comprobar si choca mirar cada coordenada de la pieza si es 1.
    # Borrado dependiendo hacia donde se mueve borrar una linea o columna del lando 
    # Contrario hacia donde se mueve
    # crear una matriz con la x e y y las que no sean igual a la matriz del dibujo y uno borarr xy1

}


