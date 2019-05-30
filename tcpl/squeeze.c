/* TCPL 2.4. Write an alternate version of squeeze(s1,s2) that deletes each
character in s1 that matches any character in the string s2.
TCPL 2.5. Write the function any(s1,s2), which return the first location in
the string s1 where any character from the string s2 occurs, or -1 if s1
contains no characters from s2. */
#include <stdio.h>

void squeeze(char s1[], char s2[]);
int any(char s1[], char s2[]);

int main() {
    char s1[100], s2[100];
    printf("where to search: ");    scanf("%s", s1);
    printf("what to search: ");     scanf("%s", s2);

    int pos = any(s1, s2);
    if(pos > 0) {
        printf("found characters at %d\n", pos);
        squeeze(s1, s2);
        printf("squeezed string: %s\n", s1); 
    }
    else
        printf("didn't found any characters\n");

    return 0;
}

void squeeze(char s1[], char s2[]) {
    int i;
    for(i = 0; s2[i] != '\0'; ++i) {
        int c = s2[i], j, k;
        for(k = j = 0; s1[j] != '\0'; ++j)
            if(s1[j] != c)
                s1[k++] = s1[j];
        s1[k] = '\0';
    }
}

int any(char s1[], char s2[]) {
    int i, j;
    for(i = 0; s2[i] != '\0'; ++i)
        for(j = 0; s1[j] != '\0'; ++j)
            if(s1[j] == s2[i])
                return j + 1;
    return -1;
}