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

# Function to rotate coordinates 90 degrees clockwise
rotate_90() {
    local coordinates="$1"
    local origin_x="$2"
    local origin_y="$3"
    local rotated_coordinates=()

    IFS=' ' read -r -a coords <<< "$coordinates"
    for coord in "${coords[@]}"; do
        IFS=',' read -r x y value <<< "$coord"
        # Calculate new coordinates
        local new_x=$((origin_y - (y - origin_y)))
        local new_y=$((x - origin_x + origin_y))
        rotated_coordinates+=("$new_x,$new_y,$value")
    done

    echo "${rotated_coordinates[@]}"
}

# Function to draw a piece in its rotated positions
draw_rotated_piece() {
    local piece_name="$1"
    local piece_coordinates="${pieces[$piece_name]}"
    local origin_x=$start_x
    local origin_y=$start_y

    # Draw the piece in its original position
    clear_screen
    draw_piece "$piece_coordinates"

    # Calculate rotated positions and draw them
    local rotated_coords_90=$(rotate_90 "$piece_coordinates" "$origin_x" "$origin_y")
    local rotated_coords_180=$(rotate_90 "$rotated_coords_90" "$origin_x" "$origin_y")
    local rotated_coords_270=$(rotate_90 "$rotated_coords_180" "$origin_x" "$origin_y")

    # Draw rotated positions with offsets
    #move_cursor "$origin_x" "$((origin_y + 10))"
    #draw_piece "$rotated_coords_90"
    move_cursor "$origin_x" "$((origin_y + 20))"
    draw_piece "$rotated_coords_180"
    #move_cursor "$origin_x" "$((origin_y + 30))"
    #draw_piece "$rotated_coords_270"

    # Move cursor to a new line after drawing
    move_cursor 0 $((origin_y + 40))
}

# Function to process all pieces
process_all_pieces() {
    pieces_value=(
        "1,1,1,1,1,1,9,0,0,1,1,0,0,T" # piece_T
        "1,1,1,1,9,1,1,1,1,O"
        "1,1,9,1,1,9,1,1,9,1,1"
        "1,1,1,1,0,0,0,0,9,0,0,0,0,1,1,1,1"
    )

    local y=$start_y
    for piece in "${pieces_value[@]}"; do
        process_piece "$piece"
        # Update the starting y position for the next piece, incrementing by 5
        ((y += 5))
        start_y=$y
    done
}

# Main script execution
process_all_pieces
draw_rotated_piece "T"
