int: n;
int: k;
array[1..n] of int: target;
array[1..k, 1..n] of 0..1: button;
array[1..k] of var 0..1000: weight;

constraint forall (i in 1..n) (
    sum (j in 1..k) (weight[j] * button[j, i]) = target[i]);

var int: cost = sum(weight);

solve minimize cost;

output show(cost);
