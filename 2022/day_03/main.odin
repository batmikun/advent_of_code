package main

import "core:os"
import "core:strings"
import "core:fmt"
import "core:slice"
import "core:unicode"

part := "part_2"

values := map[rune]int{
    'a' = 1,
    'b' = 2,
    'c' = 3,
    'd' = 4,
    'e' = 5,
    'f' = 6,
    'g' = 7,
    'h' = 8,
    'i' = 9,
    'j' = 10,
    'k' = 11,
    'l' = 12,
    'm' = 13,
    'n' = 14,
    'o' = 15,
    'p' = 16,
    'q' = 17,
    'r' = 18,
    's' = 19,
    't' = 20,
    'u' = 21,
    'v' = 22,
    'w' = 23,
    'x' = 24,
    'y' = 25,
    'z' = 26,
}

main :: proc() {
    filepath := "input.txt"
    data, ok := os.read_entire_file(filepath, context.allocator)
    if !ok {
        return
    }
    defer delete(data, context.allocator)

    runsacks := strings.split(string(data), "\r\n")
    if part == "part_1" {
        total_sum_priorities: int
        for runsack in runsacks {
                first_compartiment := runsack[:len(runsack) / 2]
                second_compartiment := runsack[len(runsack) / 2:]
                contains : [dynamic]rune

                for item in first_compartiment {
                    if strings.contains_rune(second_compartiment, item) >= 0 && !slice.contains(contains[:], item){
                        append(&contains, item)

                        if unicode.is_upper(item) {
                            total_sum_priorities += values[unicode.to_lower(item)] + 26
                        } else {
                            total_sum_priorities += values[item]
                        }
                    }
                }
        }

        fmt.println(total_sum_priorities)
    } else {
        total_sum_priorities: int

        for len(runsacks) > 0 {
            contains : [dynamic]rune
            group, rest := slice.split_at(runsacks, 3) 
            runsacks = rest
            for char in group[0] {
                if strings.contains_rune(group[1], char) >= 0 && strings.contains_rune(group[2], char) >= 0 && !slice.contains(contains[:], char) {
                    append(&contains, char)
                    if unicode.is_upper(char) {
                        total_sum_priorities += values[unicode.to_lower(char)] + 26
                    } else {
                        total_sum_priorities += values[char]
                    }
                }
            } 
        }

        fmt.println(total_sum_priorities)
    }

}