#include <stdio.h>
#include <unistd.h>
#include <time.h>

#define MAX 100
#define LEN 300

int square (int a){
    return a * a;
}

int cubed (int a){
    return square(a) * a;
}

int main () {
    int a = 2;
    square(a);
    cubed(a);
    return 0;
}
