#include "screen.h"
void test(){
  unsigned char * frameBuffer = (unsigned char *) VIDEO_ADDRESS;
  for (unsigned int i=0;i<20;i=i+2){
    writeCell(frameBuffer,'Z',i,0,15);
  }
}
/** clearFrameBuffer
*
**/
void clearFrameBuffer(unsigned char *frameBuffer){
  unsigned int numberOfCells = 80*25*2;
  for (int i=0;i<numberOfCells;i++){
    writeCell(frameBuffer,0x00,i,0x00,0x00);
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

/** fbWrite: write string to frameBuffer
**/
/*
int fbWrite(char *string){
  // print string to selected row/col location
  // print string to current position or
  // print string to cursor position
  // return string length ?
  int length=-1;
  return length;
}
*/
int fbWrite(char *string,int length,int location){
  enum color bg=black;
  enum color fg=white;
  return fbWriteColor(string,length,location,bg,fg);
}
int fbWriteColor(char *string,int length,int location,unsigned char bg,unsigned char fg){
  unsigned char * frameBuffer = (unsigned char *) VIDEO_ADDRESS;
  int c = -1;
  // translate screen cell location to video_address location
  // remember 1 cell in framebuffer is 2bytes (1byte for ascii
  // char and 1 byte for the attributes fg and bg colors)

  // loop through each char in string and write to framebuffer
  for (int i=0;i<length;i++){
    int next = 2*i;
    writeCell(frameBuffer,string[i],sLoc2fLoc(location)+next,bg,fg);
    c++;
  }
  return c;
}
int sLoc2fLoc(int screenLocation){
  int frameLocation = 2 * (screenLocation - ( screenLocation % 2 ));
  return frameLocation;
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
