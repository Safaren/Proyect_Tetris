# Definir las piezas y funciones del Tetris

# Definimos la pieza I en sus orientaciones (0: horizontal, 1: vertical)
declare -A PIEZAS
PIEZAS["I_0"]="0,0 1,0 2,0 3,0"
PIEZAS["I_1"]="0,0 0,1 0,2 0,3"

# Función para dibujar una pieza en la pantalla
dibujar_pieza() {
    local tipo_pieza=$1
    local orientacion=$2
    local x=$3
    local y=$4
    local char=${5:-"#"}

    # Obtén las coordenadas relativas de la pieza
    local coords="${PIEZAS["${tipo_pieza}_${orientacion}"]}"

    # Itera sobre las coordenadas y dibuja cada bloque
    for coord in $coords; do
        local rel_x=$(echo $coord | cut -d, -f1)
        local rel_y=$(echo $coord | cut -d, -f2)
        local abs_x=$((x + rel_x))
        local abs_y=$((y + rel_y))

        # Usa tput para mover el cursor y dibujar el bloque
        tput cup $abs_y $abs_x
        echo -n "$char"
    done
}

# Función para rotar una pieza
rotar_pieza() {
    local tipo_pieza=$1
    local orientacion_actual=$2

    # Determina la nueva orientación
    local nueva_orientacion=$(( (orientacion_actual + 1) % 2 )) # Suponiendo 2 orientaciones (0 y 1)

    echo $nueva_orientacion
}

# Función para mover una pieza
mover_pieza() {
    local tipo_pieza=$1
    local orientacion=$2
    local x_actual=$3
    local y_actual=$4
    local dx=$5
    local dy=$6

    # Borra la pieza actual
    dibujar_pieza $tipo_pieza $orientacion $x_actual $y_actual " "

    # Calcula la nueva posición
    local nuevo_x=$((x_actual + dx))
    local nuevo_y=$((y_actual + dy))

    # Dibuja la pieza en la nueva posición
    dibujar_pieza $tipo_pieza $orientacion $nuevo_x $nuevo_y "#"
}

# Función para borrar una pieza
borrar_pieza() {
    local tipo_pieza=$1
    local orientacion=$2
    local x=$3
    local y=$4

    dibujar_pieza $tipo_pieza $orientacion $x $y " "
}

# Variables iniciales
x=5
y=5
orientacion=0

# Dibujar la pieza I en la posición inicial
dibujar_pieza "I" $orientacion $x $y

# Esperar un segundo
sleep 1

# Rotar la pieza
orientacion=$(rotar_pieza "I" $orientacion)
borrar_pieza "I" $orientacion $x $y
dibujar_pieza "I" $orientacion $x $y

# Esperar otro segundo
sleep 1

# Mover la pieza hacia la derecha y abajo
mover_pieza "I" $orientacion $x $y 1 1
