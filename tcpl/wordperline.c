// TCPL 1.12. Write a program that prints its input one word per line.
#include <stdio.h>

int main() {
    int c = getchar();
    if(c == EOF) {
        return 0;
    }
    else if(c != ' ' && c != '\n' && c != '\t') {
        putchar(c);
    }

    int wsp = 0;
    while((c = getchar()) != EOF) {
        if(c == ' ' || c == '\n' || c == '\t') {
            if(!wsp)
                putchar('\n');
            wsp = 1;
        }
        else if(c != ' ' && c != '\n' && c != '\t') {
            putchar(c);
            wsp = 0;
        }
    }

    return 0;
}
