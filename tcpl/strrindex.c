/* TCPL 4.1. Write the function strrindex(s,t), which returns the position of
the rightmost occurense if t in s, or -1 fi there is none. */
#include <stdio.h>
#include <stdlib.h>

int strrindex(char s[], char t[]);

int main() {
    char *s = NULL, *t = NULL;
    size_t len = 0;
    printf("s: "); getline(&s, &len, stdin);
    printf("t: "); getline(&t, &len, stdin);
    int pos;
    if((pos = strrindex(s,t)) > 0)
        printf("`t` occured in `s` lastly at %d\n", pos);
    else
        printf("`t` isn't in `s`\n");
    free(s);
    free(t);
    return 0;
}

int strrindex(char s[], char t[]) {
    int slen, tlen;
    for(slen = 0; s[slen] != '\n'; ++slen);
    for(tlen = 0; t[tlen] != '\n'; ++tlen);
    int i = slen-1, j = tlen-1, k;
    for(; i != -1; --i) {
        for(k = 0; s[i-k-1] == t[j-k-1]; ++k);
        if(k == j)
            return i - k + 1;
    }
    return -1;
}