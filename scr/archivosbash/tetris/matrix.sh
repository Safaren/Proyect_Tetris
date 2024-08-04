source ./variables.sh


# Función inicializar la matriz a 0
initialize_matrix()
{
  local height=$1
  local width=$2
  

  for ((i=0; i<height; i++)); do
      for ((j=0; j<width; j++)); do
          matrix[$i,$j]=${board[$i,$j]}
      done
  done
}

