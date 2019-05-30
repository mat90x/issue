/*  TCPL 1.14. Write a program to print a histogram of the lengths of words in
its input. It is easy to draw the histogram with the bars horizontal; a
vertical orientation is more challenging.   */
#include <stdio.h>

int main() {
    const int arrlen = 20;
    int lens[20];

    int i;
    for(i = 1; i < arrlen; ++i) {
        lens[i] = 0;
    }

    int c;
    int word_len = 0;;
    while((c = getchar()) != EOF) {
        if(c == ' ' || c == '\n' || c == '\t') {
            if(word_len > 19) {
                word_len = 19;
            }
            ++lens[word_len];
            word_len = 0;
            continue;
        }
        ++word_len; 
    }

    if(word_len > 19) {
        word_len = 19;
    }
    ++lens[word_len];

    // horizontal view
    printf("\n");
    for(i = 1; i < arrlen; ++i) {
        printf("%3d: ", i);
        int j;
        for(j = 0; j < lens[i]; ++j) {
            printf("x");
        }
        printf("\n");
    }
  
    printf("\n\n");

    // vertical view
    int word_len_max = 0;
    for(i = 1; i < arrlen; ++i) {
        if(lens[i] > word_len_max ) {
            word_len_max = lens[i];
        }
    }

    int level;
    for(level = word_len_max; level > 0; --level) {
        for(i = 1; i < arrlen; ++i) {
            if(lens[i] >= level) {
                printf(" x ");
            }
            else {
                printf("   ");
            }
        }
        printf("\n");
    }

    for(i = 1; i<arrlen; ++i) {
        if(i >= 10) {
            printf(" %d", i);
        }
        else {
            printf(" %d ", i);
        }
    }
    printf("\n\n");

    return 0;
}
