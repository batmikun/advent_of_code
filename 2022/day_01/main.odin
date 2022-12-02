package main

import "core:os"
import "core:strings"
import "core:fmt"
import "core:strconv"
import "core:slice"

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

    for value in elf_load {
        if value == "" {
            append(&elf_sum_array, elf_sum)
            elf_sum = 0
            continue
        }

        int_value, err := strconv.parse_int(value)
        if !err {
            fmt.println("There was an error parsing the number : ", value)
        }

        elf_sum = elf_sum + int_value
    }

    slice.reverse_sort(elf_sum_array[:])

    fmt.println("Result for parth one : ", elf_sum_array[0])    

    sum := elf_sum_array[0] + elf_sum_array[1] + elf_sum_array[2]
    fmt.println(sum)
}