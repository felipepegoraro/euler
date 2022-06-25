#include <stdio.h>

int reverse(int z){
	int rev=z;
	int lst;
	while (z>0){
		lst = z%10;
		rev = (rev*10)+lst;
		z = z/10;
	}
	return rev;
}

int main(void){
	int res, z, max, maximox=0, maximoy=0;
	int x=1, y=1, palindrome;

	for (x=100; x<1000; x++){
		for (y=100; y<1000; y++){
			z=x*y;
			res=z/1000; 
			if (z == reverse(res) && max<z) { 
				maximox=x, maximoy=y;
				max=maximox*maximoy;
			}
		}
	}
	// max=maximox*maximoy;
	printf("%d\n", max);

	return 0;
}
