#!/bin/bash



#librery
source ./board.sh
source ./pieces.sh
source ./variables.sh
source ./colisions.sh




hide_cursor() {
    echo -ne "$HIDECURSOR"
    stty -echo # evita que se escriban caracteres
    stty -icanon # evita que se tenga que pulsar enter para enviar el caracter
}

show_cursor() {
    echo -ne "$RESTORECURSOR"
    stty echo # evita que se escriban caracteres
    stty icanon
}


clear
hide_cursor
initialize_board $HEIGHT $WIDTH
draw_board $HEIGHT $WIDTH

#draw_piece o_piece 10 1
#print_board 5 5
while true; do


check_collision
clear_piece O_piece cxm cym

sleep 0.5;
cym=$((ym-1));
cxm=$xm;
ym=$((ym + 1)) 

draw_piece O_piece xm ym

trap 'show_cursor' EXIT
done


