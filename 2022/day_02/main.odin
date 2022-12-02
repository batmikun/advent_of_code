package main

import "core:os"
import "core:strings"
import "core:fmt"

// ----------------- PART 1 only ----------------

mine_letter_to_hand : map[string]string = {
	"X" = "rock",
	"Y" = "paper",
	"Z" = "scissors",
}

// -----------------------------------------------

// ----------------- PART 2 only -----------------

what_i_have_to_do : map[string]string = {
	"X" = "lose",
	"Y" = "draw",
	"Z" = "win",
}

// -----------------------------------------------

part :: "part_2"

theirs_letter_to_hand : map[string]string = {
	"A" = "rock",
	"B" = "paper",
	"C" = "scissors",
}

rules : map[string]string = {
	"rock" = "scissors",
	"paper" = "rock",
	"scissors" = "paper",
}

points : map[string]int = {
	"rock" = 1,
	"paper" = 2,
	"scissors" = 3,
	"lost" = 0,
	"draw" = 3,
	"win" = 6,
}

main :: proc() {
    filepath := "input.txt"
    data, ok := os.read_entire_file(filepath, context.allocator)
    if !ok {
        return
    }
    defer delete(data, context.allocator)

    elf_load := strings.split(string(data), "\r\n")

    elf_sum_array: [dynamic]int
    elf_sum: int

    points_for_game : int
    points_for_round : int

    for value in elf_load {
    	points_for_round = 0

    	pair := strings.split(value, " ")

    	his_hand := theirs_letter_to_hand[pair[0]]

    	if part == "part_1" {
    		mi_hand := mine_letter_to_hand[pair[1]]

			points_for_round += points[mi_hand]

			if mi_hand == his_hand {
				points_for_round += points["draw"]
				points_for_game += points_for_round
				continue
			}

			if rules[mi_hand] == his_hand {
				points_for_round += points["win"]
				points_for_game += points_for_round
				continue
			}

			points_for_round += points["lost"]
			points_for_game += points_for_round
    	} else {
    		what_to_do := what_i_have_to_do[pair[1]]	

    		if what_to_do == "lose" {
    			mi_hand := rules[his_hand] 

    			points_for_round += points[mi_hand]
    			points_for_round += points["lose"]

    			points_for_game += points_for_round
    		} else if what_to_do == "draw" {
    			mi_hand := his_hand

    			points_for_round += points[mi_hand]
    			points_for_round += points["draw"]

    			points_for_game += points_for_round
    		} else {
    			mi_hand := rules[rules[his_hand]] 

    			points_for_round += points[mi_hand]
    			points_for_round += points["win"]

    			points_for_game += points_for_round
    		}
    	}

    	
    }

    fmt.println(points_for_game)
}