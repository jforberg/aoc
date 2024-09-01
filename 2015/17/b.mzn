array [1..20] of int: cont = [
    43, 3, 4, 10, 21, 44, 4, 6, 47, 41, 34, 17, 17, 44, 36, 31, 46, 9, 27, 38
];

array [1..20] of var 0..1: used;

var int: tot_used = sum (i in 1..20) (used[i] != 0);

constraint sum (i in 1..20) (cont[i] * used[i]) == 150;

constraint tot_used = 4;

%solve minimize tot_used;
solve satisfy;

