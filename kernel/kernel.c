#include "../drivers/screen.h"

void main(){
	char * videoBuffer = (char *) 0xb8000;
	*videoBuffer = 'X';
	clearFrameBuffer(videoBuffer);
	enum color fg=magenta;
	enum color bg=0;
	for (unsigned int i = 20; i<100;i+=2){
		writeCell(videoBuffer,'X',i,bg,fg);
	}
}
