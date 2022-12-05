def main():
    part_1 = 0
    part_2 = 0

    with open("input.txt") as f:
        contents = f.read().split("\n")

    for pair in contents:
        one, two = pair.split(",")

        a_1, a_2 = one.split("-")
        b_1, b_2 = two.split("-")

        a_1, a_2, b_1, b_2 = [int(x) for x in [a_1, a_2, b_1, b_2]]

        if (a_1 <= b_1 and b_2 <= a_2) or (b_1 <= a_1 and a_2 <= b_2):
            part_1 += 1

        if not (a_2 < b_1 or a_1 > b_2):
            part_2 += 1

    print(part_1)
    print(part_2)


main()
