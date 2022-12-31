def main():
    file = open("input.txt")
    file = file.read()

    print(find_marker_start(file, 4)) # PART 1
    print(find_marker_start(file, 14)) # PART 2 

def find_marker_start(chr_chain, number_of_distintc_characters):
    passed_chr = []
    result = 0

    for index, chr in enumerate(chr_chain):
        if len(passed_chr) == number_of_distintc_characters:
            result = index
            break

        if chr in passed_chr:
            pos = passed_chr.index(chr)
            passed_chr = passed_chr[pos+1:]

        
        passed_chr.append(chr)

    return result

def test_main():
    input = [
        ("mjqjpqmgbljsphdztnvjfqwrcgsmlb", 7, 19),
        ("bvwbjplbgvbhsrlpgdmjqwftvncz", 5, 23),
        ("nppdvjthqldpwncqszvftbrmjlhg", 6, 23),
        ("nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg", 10, 29),
        ("zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw", 11, 26),
    ]

    for chain in input:
        result_1 = find_marker_start(chain[0], 4)
        result_2 = find_marker_start(chain[0], 14)

        assert result_1 == chain[1]
        assert result_2 == chain[2]

if __name__ == '__main__':
    main()
    test_main()
