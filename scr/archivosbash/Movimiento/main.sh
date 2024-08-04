#!/bin/bash

# Initialize an associative array to store pieces
declare -A pieces

# Define initial coordinates
start_x=5
start_y=5

# Function to process a piece
process_piece() {
    local piece="$1"
    IFS=',' read -r -a elements <<< "$piece"
    local name="${elements[-1]}"
    local coordinates=()
    local x=$start_x
    local y=$start_y

    for (( i=0; i<${#elements[@]}-1; i++ )); do
        local value="${elements[$i]}"
        coordinates+=("$x,$y,$value")
        ((x++))

        if [[ "$value" == "9" ]]; then
            ((y++))
            x=$start_x
        fi
    done
    pieces[$name]="${coordinates[@]}"
}

# Function to draw a piece
draw_piece() {
    local piece_coordinates="$1"
    IFS=' ' read -r -a coords <<< "$piece_coordinates"
    for coord in "${coords[@]}"; do
        IFS=',' read -r x y value <<< "$coord"
        local char=" "
        if [[ "$value" == "1" ]]; then
            char="▓"
        fi
        # Move cursor to (x, y) and print the character
        echo -ne "\033[${y};${x}H$char"
    done
}

# Function to process all pieces
process_all_pieces() {
    
    local y=$start_y

    pieces_value=(
        "1,1,1,1,1,1,9,0,0,1,1,0,0,T" # piece_T
        "1,1,1,1,9,1,1,1,1,O"
        "1,1,9,1,1,9,1,1,9,1,1,I"
        "1,1,1,1,0,0,9,0,0,1,1,1,1,Z"
        "1,1,9,1,1,9,1,1,1,1,L"
        "0,0,1,1,9,0,0,1,1,9,1,1,1,1,LI"
    )

    for piece in "${pieces_value[@]}"; do
        process_piece "$piece"
        ((y += 5))
        start_y=$y
    done
}

# Function to clear the screen
clear_screen() {
    echo -ne "\033[2J"
}

# Function to move cursor to a specific position
move_cursor() {
    local x="$1"
    local y="$2"
    echo -ne "\033[${y};${x}H"
}

# Main function to draw all pieces
draw_all_pieces() {
    clear_screen

    for key in "${!pieces[@]}"; do
        draw_piece "${pieces[$key]}"
    done

    # Move cursor to a new line after drawing
    move_cursor 0 $((start_x + 10))
}

draw_specific_piece() {
    local piece_name="$1"
    local piece_coordinates="${pieces[$piece_name]}"
    if [[ -n "$piece_coordinates" ]]; then
        #clear_screen
        draw_piece "$piece_coordinates"
        # Move cursor to a new line after drawing
        move_cursor 0 $((start_y + 10))
    else
        echo "Pieza $piece_name no encontrada."
    fi
}

# Main script execution

process_all_pieces

draw_specific_piece T
#draw_all_pieces
