#include <stdio.h>
#include <stdbool.h>
int main() {
int N;
int SQRT;
bool N;
{int i; scanf("%d", &i);N = i;}
SQRT = 0;
while(SQRT*SQRT<=N) {
SQRT = SQRT+1;
}
SQRT = SQRT-1;
printf("%d\n", SQRT);
return 0;
}
