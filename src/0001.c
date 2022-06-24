#include <stdio.h>

// desafio: https://projecteuler.net/problem=1

int main(void)
{
	int a=0;
	for (int i=0; i<=999; i++)
		if (i%3==0 || i%5==0)
			a += i;

	printf("%d\n", a);

	return 0;
}
