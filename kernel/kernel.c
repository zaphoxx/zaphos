#include "../drivers/screen.h"
void main(){
	char * videoBuffer = (char *) 0xb8000;
	*videoBuffer = 'X';
	test();
}
