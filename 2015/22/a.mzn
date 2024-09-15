int: T = 30;

enum Spell = { S_start, S_boss, S_mm, S_drain, S_shield, S_poison, S_recharge };

array [S_start..S_recharge] of int: cost = [ 0, 0, 53, 73, 113, 173, 229 ];

% 1. Record values 2. Apply effect 3. Attack

% Spell cast this turn
array [0..T] of var Spell: spells;
constraint spells[0] = S_start;
constraint forall (i in 1..T where i mod 2 == 0) (spells[i] == S_boss);
constraint forall (i in 1..T where i mod 2 != 0) (spells[i] != S_boss /\ spells[i] != S_start);

array [S_start..S_recharge] of int: duration = [0, 0, 0, 0, 6, 6, 5];

% Turns left of effect at the START of the turn, before application
array [{S_shield, S_poison, S_recharge}, 0..T] of var 0..10: eff;
constraint forall (e in index_set_1of2(eff)) (eff[e, 0] = 0);
constraint forall (e in index_set_1of2(eff)) (eff[e, 1] = 0);
constraint forall (e in index_set_1of2(eff), t in 2..T)
    (if spells[t - 1] = e then
        eff[e, t] = duration[e] else
        eff[e, t] = max(0, eff[e, t - 1] - 1) endif);
constraint forall (e in index_set_1of2(eff), t in 1..T)
    (eff[e, t] > 1 -> spells[t] != e);

% Mana left at END of turn, after casting
array [0..T] of var int: mana;
constraint forall (t in 1..T) (boss_hp[t] > 0 -> mana[t] >= 0);
constraint mana[0] = 500;
constraint forall (t in 1..T)
    (mana[t] == mana[t - 1] +
        (if eff[S_recharge, t] > 0 then 101 else 0 endif) -
        cost[spells[t]]);

% Damage the boss would do this turn if attacking
int: boss_base_dmg = 10;
array [1..T] of var int: boss_dmg;
constraint forall (t in 1..T)
    (if eff[S_shield, t] > 0
        then boss_dmg[t] = max(1, boss_base_dmg - 7)
        else boss_dmg[t] = boss_base_dmg endif);

% HP that I have at the END of this turn
array [0..T] of var int: my_hp;
constraint my_hp[0] = 50;
constraint forall (t in 1..T)
    (if t mod 2 == 0 then
        my_hp[t] = my_hp[t - 1] - boss_dmg[t] else
        my_hp[t] = my_hp[t - 1] + (if spells[t] == S_drain then 2 else 0 endif) endif);
constraint forall (t in 1..T) (boss_hp[t] > 0 -> my_hp[t] > 0);

% HP that hoss has at the END of this turn
array [0..T] of var int: boss_hp;
constraint boss_hp[0] = 71;
constraint forall (t in 1..T)
    (boss_hp[t] = boss_hp[t - 1] -
        if spells[t] == S_mm then 4 elseif
            spells[t] == S_drain then 2 else 0 endif -
            if eff[S_poison, t] > 0 then 3 else 0 endif);

var 1..T: boss_die_at = min (t in 1..T where boss_hp[t] <= 0) (t);

var int: spent_mana = sum (t in 1..boss_die_at) (cost[spells[t]]);

solve :: int_search(spells, first_fail, indomain_min)
    minimize spent_mana;

output show(spent_mana);

%output [
%    "\nspells = ", show(spells),
%    "\nmana = ", show(mana),
%    "\nmy_hp = ", show(my_hp),
%    "\nboss_hp = ", show(boss_hp),
%    "\neff_shield = ", show(eff[S_shield, ..]),
%    "\neff_poison = ", show(eff[S_poison, ..]),
%    "\neff_recharge = ", show(eff[S_recharge, ..]),
%    "\nboss_dmg = ", show(boss_dmg),
%    "\nboss_die_at = ", show(boss_die_at),
%    "\nspent_mana = ", show(spent_mana),
%];
