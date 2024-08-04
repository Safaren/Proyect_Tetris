#!/bin/bash


#Dimensiones del tablero
HEIGHT=30;
WIDTH=44;

# Tablero
declare -A board

# Crear la matriz
declare -A matrix

# Caracteres tablero
CHAR_VERTICAL='║'
CHAR_HORIZONTAL='═'
CHAR_TOP_LEFT='╔'
CHAR_BOTTOM_LEFT='╚'
CHAR_TOP_RIGHT='╗'
CHAR_BOTTOM_RIGHT='╝'
CHAR_EMPTY=" "

# Piezas
declare -A pieces

# Colores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'
border_color="\e[30;43m"
MANGENTA='\033[0;35m'
GREEN_BACKGROUND='\033[42;30m'
GRENN_BACK_MANG='\033[42;35m'
RESET_COLOR="\e[0m"

# Secuencias ASCII
HIDECURSOR="\033[?25l"
RESTORECURSOR="\033[?25h"
MOVE="\033[%d;%dH"


# Velocidad del juego
SLEEP_TIME=0.3

# Posicion pieza

ym=2
xm=$((WIDTH / 2))

# Posición pieza para borrar

cym=0
cxm=0


