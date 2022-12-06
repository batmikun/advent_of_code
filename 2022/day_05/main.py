from copy import deepcopy

file = open("input.txt")

contents = file.read().split("\n")

array_stacks: list[list[str]] = []
orders: str = ""

crates = contents[:contents.index("")]

for line_of_crates in crates:
    size = (len(line_of_crates) + 1) // 4

    while len(array_stacks) < size:
        array_stacks.append([])

    for i in range(len(array_stacks)):
        crate = line_of_crates[1 + 4 * i]

        if crate != ' ' and 'A' <= crate <= 'Z':
            array_stacks[i].append(crate)

array_stacks_1 = deepcopy(array_stacks)
array_stacks_2 = deepcopy(array_stacks)

moves = contents[contents.index("") + 1:]
for move in moves:
    new = move.replace("move ", "").replace(" from ", " ").replace("to ", "")
    qty, from_, to_ = new.split(" ")
    from_ = int(from_) - 1
    to_ = int(to_) - 1
    qty = int(qty)

    for (ST, do_rev) in [(array_stacks_1, True), (array_stacks_2, False)]:
        MOVE = ST[from_][:qty]
        ST[from_] = ST[from_][qty:]
        ST[to_] = (list(reversed(MOVE)) if do_rev else MOVE) + ST[to_]

print(''.join([s[0] for s in array_stacks_1 if len(s) > 0]))
print(''.join([s[0] for s in array_stacks_2 if len(s) > 0]))
