#include "screen.h"
void test(){
  unsigned char * frameBuffer = (unsigned char *) VIDEO_ADDRESS;
  for (unsigned int i=0;i<20;i=i+2){
    writeCell(frameBuffer,'Z',i,0,15);
  }
}
/** write_cell:
* @param *fb framebuffer pointer to write to
* @param character
* @param i location in framebuffer
* @param bg background color
* @param fg foreground color
**/
void writeCell(unsigned char *frameBuffer,
                char character,
                unsigned int location,
                unsigned char backgroundColor,
                unsigned char foregroundColor){
  frameBuffer[location]=character;
  frameBuffer[location+1]=((backgroundColor & 0x0f) << 4) | (foregroundColor & 0x0f);
}
/** printc:
* print a single char to the screen
* @param character - character to print
* @param col - column
* @param row - row
* @param attribute_byte - foreground, background color)
**/
/*
void printChar(char character,int col, int row, char attribute_byte){
  unsigned char *videoMem=(unsigned char*) VIDEO_ADDRESS;
  if(!attribute_byte){
    attribute_byte=COLOR;
  }
  // get video memory offset for the screen location
  int offset;
  if(col >=0 && row >= 0){
    offset=get_screen_offset(col,row);
  }else{
    offset=get_cursor();
  }
  if(character == '\n'){
    int rows = offset / (2*MAX_COLS);
    offset = get_screen_offset(79,rows);
  }else{
    videoMem[offset]=character;
    videoMem[offset+1]=attribute_byte;
  }
  offset += 2;
  offset = handle_scrolling(offset);
  set_cursor(offset);
}
*/
