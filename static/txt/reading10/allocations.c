/* allocations.c */

#include <stdio.h>
#include <stdlib.h>

typedef struct {
    double x;
    double y;
} Point;

typedef union {
    char   c;
    int    i;
    float  f;
    double d;
} Block;

double GD = 3.14;

int main(int argc, char *argv[]) {
    int    a[]	= {5, 7, 4};
    char  *sp	= "Video Games";
    char   sa[]	= "Runescape";
    Block  b    = {0};

    Point   p0	= {0, 0};
    Point  *p1	= NULL;
    Point  *p2	= malloc(sizeof(Point));
    Point  *p3	= malloc(5*sizeof(Point));
    Point **p4	= malloc(5*sizeof(Point *));

    return 0;
}
