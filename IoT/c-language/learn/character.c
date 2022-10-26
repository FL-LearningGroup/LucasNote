#include <stdio.h>

int main()
{
    int c;
    c = getchar();
    printf("%d\n", c);
    while (c != EOF)
    {
        /* code */
        putchar(c);
        c = getchar();
    }
    
    return 0;    
}