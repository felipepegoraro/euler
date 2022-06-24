#include <stdio.h>

// https://projecteuler.net/problem=2

int main(void)
{
	int a=1, b=1, c=0;
	int soma=0;

	while (c < 4000000){
		if (c % 2 == 0)
			soma += c;		
		a=b, b=c, c=a+b;
	}

	printf("%d\n", soma);

	return 0;
}
