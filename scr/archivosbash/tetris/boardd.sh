#!/bin/bash



# Función para establecer que caracter se tiene que dibujar
get_char() {
  local x=$1
  local y=$2
  #local -n arr=$3
 if [[ ($x -eq 0  || $x -eq $((WIDTH-1)))  && ($y -gt 0 && $y -lt $((HEIGHT-1))) ]]; then
    echo -e "${GREEN_BACKGROUND}${CHAR_VERTICAL}${RESET_COLOR}";

  elif [[ ($y -eq 0 || $y -eq $(($HEIGHT-1))) && ($x -gt 0 && $x -lt $((WIDTH-1))) ]] ; then
    echo -e "${GREEN_BACKGROUND}${CHAR_HORIZONTAL}${RESET_COLOR}"
  else
     case "$x,$y" in
    "0,0")
      echo -e "${GRENN_BACK_MANG}${CHAR_TOP_LEFT}${RESET_COLOR}"
      ;;
    "0,$((HEIGHT - 1))")
      echo -e "${GRENN_BACK_MANG}${CHAR_BOTTOM_LEFT}${RESET_COLOR}"
      ;;
    "$((WIDTH - 1)),0")
      echo -e "${GRENN_BACK_MANG}${CHAR_TOP_RIGHT}${RESET_COLOR}"
      ;;
    "$((WIDTH - 1)),$((HEIGHT - 1))")
      echo -e "${GRENN_BACK_MANG}${CHAR_BOTTOM_RIGHT}${RESET_COLOR}"
      ;;
      *)
      echo " "
      ;;
  esac
   fi
   ##echo "$((x + 3)) $((y + 3))"
}



# Función para inicializar el tablero con bordes y espacios
initialize_board() {
    local height=$1
    local width=$2
  for ((y=0; y < $height; y++)); do
    for ((x=0; x < $width; x++)); do
      board[$x,$y]=$(get_char $x $y $board) 
    done
  done
}

# Función para mostrar el tablero
print_board() {
    local height=$1
    local width=$2
  for ((y=0; y < $height; y++)); do
    for ((x=0; x < $width; x++)); do
      echo -n "${board[$x,$y]}"
    done
    echo
  done
}