#include <stdio.h>

// https://projecteuler.net/problem=3

int main(void)
{
	int i;
	long int num = 600851475143;

	for (i=2 ; i<num; i++)
		while (num % i == 0)
      num /= i; 
	printf("%d\n", i);

	return 0;
}
