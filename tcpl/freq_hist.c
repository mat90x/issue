/*
TCPL 1.14. Write a program to print a histogram of the frequencies of different
characters in its input.
*/
#include <stdio.h>

int main() {
    const int arrlen = '~' - ' ';
    int freqs[arrlen];

    int i;
    for(i = 0; i < arrlen; ++i) {
        freqs[i] = 0;
    }

    int c;
    while((c = getchar()) != EOF) {
        ++freqs[c - ' '];
    }

    for(i = 0; i < arrlen; ++i) {
        printf("%c: ", ' ' + i);
    
        int j;
        for(j = 0; j < freqs[i]; ++j) {
            printf("x");
        }
    
        printf("\n");
    }

    return 0;
}
