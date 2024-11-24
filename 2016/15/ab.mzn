int: n;
array [1..n] of int: size;
array [1..n] of int: init;

var 0..: start;

constraint forall (i in 1..n) (
    (start + init[i] + i) mod size[i] == 0);

solve minimize start;
