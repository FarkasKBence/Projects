//beépített pályák
//easy
const easy_one = [
    [["empty", "rot0"], ["mount", "rot1"], ["empty", "rot0"], ["empty", "rot0"], ["oasis", "rot0"]],
    [["empty", "rot0"], ["empty", "rot0"], ["empty", "rot0"], ["bridge", "rot0"], ["oasis", "rot0"]],
    [["bridge", "rot0"], ["empty", "rot0"], ["mount", "rot2"], ["empty", "rot0"], ["empty", "rot0"]],
    [["empty", "rot0"], ["empty", "rot0"], ["empty", "rot0"], ["oasis", "rot0"], ["empty", "rot0"]],
    [["empty", "rot0"], ["empty", "rot0"], ["mount", "rot3"], ["empty", "rot0"], ["empty", "rot0"]]
]
const easy_two = [
    [["oasis", "rot0"], ["empty", "rot0"], ["bridge", "rot1"], ["empty", "rot0"], ["empty", "rot0"]],
    [["empty", "rot0"], ["mount", "rot2"], ["empty", "rot0"], ["empty", "rot0"], ["mount", "rot2"]],
    [["bridge", "rot0"], ["oasis", "rot0"], ["mount", "rot3"], ["empty", "rot0"], ["empty", "rot0"]],
    [["empty", "rot0"], ["empty", "rot0"], ["empty", "rot0"], ["oasis", "rot0"], ["empty", "rot0"]],
    [["empty", "rot0"], ["empty", "rot0"], ["empty", "rot0"], ["empty", "rot0"], ["empty", "rot0"]]
]
const easy_three = [
    [["empty", "rot0"], ["empty", "rot0"], ["bridge", "rot1"], ["empty", "rot0"], ["empty", "rot0"]],
    [["empty", "rot0"], ["empty", "rot0"], ["empty", "rot0"], ["empty", "rot0"], ["bridge", "rot0"]],
    [["empty", "rot0"], ["mount", "rot2"], ["bridge", "rot0"], ["empty", "rot0"], ["empty", "rot0"]],
    [["empty", "rot0"], ["oasis", "rot0"], ["empty", "rot0"], ["empty", "rot0"], ["empty", "rot0"]],
    [["empty", "rot0"], ["bridge", "rot1"], ["empty", "rot0"], ["empty", "rot0"], ["mount", "rot2"]]
]
const easy_four = [
    [["empty", "rot0"], ["empty", "rot0"], ["empty", "rot0"], ["bridge", "rot1"], ["empty", "rot0"]],
    [["empty", "rot0"], ["empty", "rot0"], ["empty", "rot0"], ["empty", "rot0"], ["empty", "rot0"]],
    [["bridge", "rot0"], ["empty", "rot0"], ["mount", "rot1"], ["empty", "rot0"], ["mount", "rot1"]],
    [["empty", "rot0"], ["empty", "rot0"], ["empty", "rot0"], ["empty", "rot0"], ["empty", "rot0"]],
    [["empty", "rot0"], ["empty", "rot0"], ["oasis", "rot0"], ["mount", "rot3"], ["empty", "rot0"]]
]
const easy_five = [
    [["empty", "rot0"], ["empty", "rot0"], ["bridge", "rot1"], ["empty", "rot0"], ["empty", "rot0"]],
    [["empty", "rot0"], ["mount", "rot0"], ["empty", "rot0"], ["empty", "rot0"], ["empty", "rot0"]],
    [["bridge", "rot0"], ["empty", "rot0"], ["empty", "rot0"], ["mount", "rot3"], ["empty", "rot0"]],
    [["empty", "rot0"], ["empty", "rot0"], ["bridge", "rot0"], ["oasis", "rot0"], ["empty", "rot0"]],
    [["empty", "rot0"], ["mount", "rot2"], ["empty", "rot0"], ["empty", "rot0"], ["empty", "rot0"]]
]

const easy = [easy_one, easy_two, easy_three, easy_four, easy_five];

//hard
const hard_one = [
    [["empty", "rot0"], ["mount", "rot1"], ["oasis", "rot0"], ["oasis", "rot0"], ["empty", "rot0"], ["bridge", "rot1"], ["empty", "rot0"]],
    [["bridge", "rot0"], ["empty", "rot0"], ["empty", "rot0"], ["empty", "rot0"], ["empty", "rot0"], ["empty", "rot0"], ["empty", "rot0"]],
    [["empty", "rot0"], ["empty", "rot0"], ["bridge", "rot0"], ["empty", "rot0"], ["empty", "rot0"], ["empty", "rot0"], ["empty", "rot0"]],
    [["empty", "rot0"], ["empty", "rot0"], ["empty", "rot0"], ["mount", "rot3"], ["empty", "rot0"], ["empty", "rot0"], ["empty", "rot0"]],
    [["mount", "rot3"], ["empty", "rot0"], ["mount", "rot1"], ["empty", "rot0"], ["bridge", "rot1"], ["empty", "rot0"], ["oasis", "rot0"]],
    [["empty", "rot0"], ["empty", "rot0"], ["empty", "rot0"], ["empty", "rot0"], ["empty", "rot0"], ["empty", "rot0"], ["empty", "rot0"]],
    [["empty", "rot0"], ["empty", "rot0"], ["empty", "rot0"], ["bridge", "rot1"], ["empty", "rot0"], ["empty", "rot0"], ["empty", "rot0"]]
]
const hard_two = [
    [["empty", "rot0"], ["empty", "rot0"], ["oasis", "rot0"], ["empty", "rot0"], ["empty", "rot0"], ["empty", "rot0"], ["empty", "rot0"]],
    [["bridge", "rot0"], ["empty", "rot0"], ["bridge", "rot1"], ["empty", "rot0"], ["empty", "rot0"], ["mount", "rot2"], ["empty", "rot0"]],
    [["empty", "rot0"], ["empty", "rot0"], ["bridge", "rot1"], ["empty", "rot0"], ["empty", "rot0"], ["empty", "rot0"], ["bridge", "rot0"]],
    [["mount", "rot0"], ["empty", "rot0"], ["empty", "rot0"], ["empty", "rot0"], ["empty", "rot0"], ["empty", "rot0"], ["empty", "rot0"]],
    [["empty", "rot0"], ["oasis", "rot0"], ["empty", "rot0"], ["mount", "rot1"], ["empty", "rot0"], ["empty", "rot0"], ["empty", "rot0"]],
    [["empty", "rot0"], ["mount", "rot0"], ["empty", "rot0"], ["empty", "rot0"], ["empty", "rot0"], ["empty", "rot0"], ["empty", "rot0"]],
    [["empty", "rot0"], ["empty", "rot0"], ["oasis", "rot0"], ["empty", "rot0"], ["empty", "rot0"], ["empty", "rot0"], ["empty", "rot0"]]
]
const hard_three = [
    [["empty", "rot0"], ["empty", "rot0"], ["bridge", "rot1"], ["empty", "rot0"], ["empty", "rot0"], ["empty", "rot0"], ["empty", "rot0"]],
    [["empty", "rot0"], ["empty", "rot0"], ["empty", "rot0"], ["empty", "rot0"], ["empty", "rot0"], ["empty", "rot0"], ["bridge", "rot0"]],
    [["oasis", "rot0"], ["empty", "rot0"], ["mount", "rot3"], ["empty", "rot0"], ["empty", "rot0"], ["empty", "rot0"], ["empty", "rot0"]],
    [["empty", "rot0"], ["empty", "rot0"], ["empty", "rot0"], ["empty", "rot0"], ["empty", "rot0"], ["empty", "rot0"], ["empty", "rot0"]],
    [["empty", "rot0"], ["oasis", "rot0"], ["mount", "rot3"], ["empty", "rot0"], ["bridge", "rot1"], ["empty", "rot0"], ["empty", "rot0"]],
    [["bridge", "rot0"], ["empty", "rot0"], ["empty", "rot0"], ["empty", "rot0"], ["empty", "rot0"], ["mount", "rot1"], ["empty", "rot0"]],
    [["empty", "rot0"], ["empty", "rot0"], ["oasis", "rot0"], ["mount", "rot3"], ["empty", "rot0"], ["empty", "rot0"], ["empty", "rot0"]]
]
const hard_four = [
    [["empty", "rot0"], ["empty", "rot0"], ["empty", "rot0"], ["empty", "rot0"], ["empty", "rot0"], ["empty", "rot0"], ["empty", "rot0"]],
    [["empty", "rot0"], ["empty", "rot0"], ["empty", "rot0"], ["bridge", "rot0"], ["empty", "rot0"], ["mount", "rot2"], ["empty", "rot0"]],
    [["empty", "rot0"], ["empty", "rot0"], ["mount", "rot3"], ["empty", "rot0"], ["empty", "rot0"], ["empty", "rot0"], ["empty", "rot0"]],
    [["empty", "rot0"], ["bridge", "rot1"], ["empty", "rot0"], ["oasis", "rot0"], ["empty", "rot0"], ["bridge", "rot1"], ["empty", "rot0"]],
    [["empty", "rot0"], ["empty", "rot0"], ["mount", "rot2"], ["empty", "rot0"], ["mount", "rot1"], ["empty", "rot0"], ["empty", "rot0"]],
    [["bridge", "rot0"], ["empty", "rot0"], ["empty", "rot0"], ["empty", "rot0"], ["empty", "rot0"], ["mount", "rot3"], ["empty", "rot0"]],
    [["empty", "rot0"], ["empty", "rot0"], ["empty", "rot0"], ["empty", "rot0"], ["empty", "rot0"], ["empty", "rot0"], ["empty", "rot0"]]
]
const hard_five = [
    [["empty", "rot0"], ["empty", "rot0"], ["empty", "rot0"], ["empty", "rot0"], ["empty", "rot0"], ["empty", "rot0"], ["empty", "rot0"]],
    [["empty", "rot0"], ["empty", "rot0"], ["empty", "rot0"], ["empty", "rot0"], ["empty", "rot0"], ["mount", "rot0"], ["empty", "rot0"]],
    [["empty", "rot0"], ["bridge", "rot1"], ["bridge", "rot1"], ["empty", "rot0"], ["mount", "rot1"], ["empty", "rot0"], ["empty", "rot0"]],
    [["empty", "rot0"], ["empty", "rot0"], ["empty", "rot0"], ["empty", "rot0"], ["empty", "rot0"], ["empty", "rot0"], ["empty", "rot0"]],
    [["empty", "rot0"], ["empty", "rot0"], ["mount", "rot0"], ["empty", "rot0"], ["oasis", "rot0"], ["empty", "rot0"], ["empty", "rot0"]],
    [["empty", "rot0"], ["mount", "rot2"], ["empty", "rot0"], ["bridge", "rot0"], ["empty", "rot0"], ["empty", "rot0"], ["empty", "rot0"]],
    [["empty", "rot0"], ["empty", "rot0"], ["empty", "rot0"], ["empty", "rot0"], ["empty", "rot0"], ["empty", "rot0"], ["empty", "rot0"]]
]
const hard = [hard_one, hard_two, hard_three, hard_four, hard_five];