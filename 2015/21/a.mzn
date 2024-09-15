array [1..16, 1..3] of int: equipment = [|
    8, 4, 0, |
    10, 5, 0, |
    25, 6, 0, |
    40, 7, 0, |
    74, 8, 0, |

    13, 0, 1, |
    31, 0, 2, |
    53, 0, 3, |
    75, 0, 4, |
    102, 0, 5, |

    26, 1, 0, |
    50, 2, 0, |
    100, 3, 0, |
    20, 0, 1, |
    40, 0, 2, |
    80, 0, 3, |
|];

var set of 1..5: weapons;
constraint card(weapons) == 1;

var set of 6..10: armours;
constraint card(armours) <= 1;

var set of 11..16: rings;
constraint card(rings) <= 2;

var set of 1..16: sel = weapons union armours union rings;

var int: cost = sum (i in sel) (equipment[i, 1]);
var int: dmg = sum (i in sel) (equipment[i, 2]);
var int: arm = sum (i in sel) (equipment[i, 3]);
int: hp = 100;

int: boss_hp = 109;
int: boss_dmg = 8;
int: boss_arm = 2;

var int: dmg_per_turn = max(1, dmg - boss_arm);
var int: boss_dmg_per_turn = max(1, boss_dmg - arm);

var int: my_turns = (boss_hp + dmg_per_turn - 1) div dmg_per_turn;
var int: boss_turns = (hp + boss_dmg_per_turn - 1) div boss_dmg_per_turn;

constraint my_turns <= boss_turns;

solve minimize cost;

output show(cost);


