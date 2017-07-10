#ifndef _SCREEN_H
#define _SCREEN_H
#define VIDEO_ADDRESS 0xb8000   // vga video memory startaddress
#define MAX_ROWS 25
#define MAX_COLS 80
#define COLOR 0x0f              // default colorscheme white on black

#define SCREEN_CTRL 0x3d4
#define SCREEN_DATA 0x3d5

void test(void);
/** write_cell:
* @param character
* @param target address
* @param attribute_byte
**/
void write_cell(unsigned char * frameBuffer,char character,unsigned int videoMem,unsigned char attribute_byte);
/** printc:
* print a single char to the screen
* @param character - character to print
* @param col - column
* @param row - row
* @param attribute_byte - foreground, background color)
**/
//void printc(unsigned char character,unsigned int col,unsigned int row,unsigned char attribute_byte);

#endif
