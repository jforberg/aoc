array [1..4, 1..4] of int: props = [|
    4, -2, 0, 0, |
    0, 5, -1, 0, |
    -1, 0, 5, 0, |
    0, 0, -2, 2,
|];

array [1..4] of var 0..100: amount;

constraint sum(amount) == 100;

array [1..4] of var int: pre_score;

constraint forall (j in 1..4) (pre_score[j] = sum (i in 1..4) (props[i, j] * amount[i]));

var int: score = product (j in 1..4) (max(0, pre_score[j]));

solve maximize score;

output [ show(score) ];
