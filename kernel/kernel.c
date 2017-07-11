#include "../drivers/screen.h"

	void main(){
		char * videoBuffer = (char *) 0xb8000;
		*videoBuffer = 'X';
		clearFrameBuffer(videoBuffer);
		enum color fg=magenta;
		enum color bg=0;
		char *string;
		string="[+] ### zaphOs v00001a ###";
		fbWriteColor(string,26,0,bg,fg);
	}
