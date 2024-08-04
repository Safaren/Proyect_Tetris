#!/bin/bash

declare -A O_piece;

#o_piece=(
#    [0,0]=1 [0,1]=1 [0,2]=1 [0,3]=1
#    [1,0]=1 [1,1]=1 [1,2]=1 [1,3]=1
#)

O_piece=("0$xm0$ym1");

Piece_O="▓▓▓▓\n"
Piece_O+="▓▓▓▓\n"
Piece_L="  ▓▓\n";
Piece_L+="  ▓▓\n";
Piece_L+="  ▓▓\n";
Piece_L+="▓▓▓▓\n"



Piece_LH="▓▓\n";
Piece_LH+="▓▓▓▓▓▓\n";

Piece_LB="▓▓▓▓\n";
Piece_LB+="▓▓  \n";
Piece_LB+="▓▓  \n";
Piece_LB+="▓▓  \n";

Piece_LHB="▓▓▓▓▓▓\n";
Piece_LHB+="    ▓▓\n";

Piece_L2=" ▓▓  \n";
Piece_L2+="▓▓  \n";
Piece_L2+="▓▓  \n";
Piece_L2+="▓▓▓▓\n";


Piece_L2HB="▓▓▓▓▓▓▓▓
\n";
Piece_L2HB+="▓▓\n";


Piece_L2B="▓▓▓▓\n";
Piece_L2B+="  ▓▓\n";
Piece_L2B+="  ▓▓\n";
Piece_L2B+="  ▓▓\n";

Piece_L2HB="▓▓▓▓▓▓\n";
Piece_L2HB+="▓▓      \n";

Piece_IV="▓▓\n";
Piece_IV+="▓▓\n";
Piece_IV+="▓▓\n";
Piece_IV+="▓▓\n";



Piece_IH="▓▓▓▓▓▓▓▓\n";

Piece_O="▓▓▓▓\n"; 
Piece_O+="▓▓▓▓\n";

Piece_T1="▓▓▓▓▓▓\n"; 
Piece_T1+="  ▓▓    \n";

Piece_T2="  ▓▓\n";
Piece_T2+="▓▓▓▓\n";
Piece_T2+="  ▓▓\n";

Piece_T3="  ▓▓\n";
Piece_T3+="▓▓▓▓▓▓\n";

Piece_T4="▓▓  \n";
Piece_T4+="▓▓▓▓\n";
Piece_T4+="▓▓  \n";

Piece_Z1="▓▓▓▓  \n";
Piece_Z1+="  ▓▓▓▓\n";

Piece_Z2="  ▓▓\n";
Piece_Z2="▓▓▓▓\n";
Piece_Z2="▓▓  \n";

Piece_Z21="  ▓▓▓▓  \n";
Piece_Z21+="▓▓▓▓\n";

Piece_Z22="▓▓ \n";
Piece_Z22+="▓▓▓▓\n";
Piece_Z22+="  ▓▓\n";



function draw_piece() {
    local piece=$1;
    local x=$3;
    local y=$2;
    ##local MOVE=$4;
    local -n matrix=$piece
    
    for i in {0..3}; do
        for j in {0..1}; do
            printf "$MOVE" $((x + j)) $((y + i)) #echo -n "${matrix[$i,$j]} "
            echo -n "▓";
        done
        echo
    done

}

function reset_piece() {
    ym=2;
    xm=$((WIDTH / 2));
}









# https://xurxodiz.eu/blog/arquivo/tetris-m/
# https://youtu.be/36Q2g6QpSXI?si=1Qb43WX2O3lKEpPt
