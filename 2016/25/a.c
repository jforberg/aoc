#include <stdio.h>
#include <stdint.h>

static uint64_t signal;
static int idx;

void func(int a)
{
    int b, c, d;

    d = a;
    c = 9;
l1: b = 282;
l0: d++;
    b--;
    if (b) goto l0;
    c--;
    if (c) goto l1;
la: a = d;
l9: ;
    b = a;
    a = 0;
l5: c = 2;
l4: if (b) goto l2;
    goto l3;
l2: b--;
    c--;
    if (c) goto l4;
    a++;
    goto l5;
l3: b = 2;
l8: if (c) goto l6;
    goto l7;
l6: b--;
    c--;
    goto l8;
l7: ;
    signal |= (((uint64_t) (!!b)) << idx); if (idx++ == 64) return;
    if (a) goto l9;
    goto la;
}

int main(void)
{
    for (int i = 1; ; i++) {
        signal = 0;
        idx = 0;
        func(i);
        if (signal == 0xaaaaaaaaaaaaaaaaull) {
            printf("%d\n", i);
            break;
        }
    }
}
