void dummy(){
  int a = 0;
}

unsigned char port_byte_in(unsigned short port){
// wrapper function that reads a byte from the specified port
// "=a" (result) means: put al register in variable RESULT when finished
// "d"  (port) means: load edx with port
  unsigned char result;
  __asm__ ("in %%dx, %%al" : "=a" (result) : "d" (port));
  return result;
}
unsigned char port_byte_out(unsigned short port,unsigned char data){
  __asm__ ("out %%al,%%dx" : "=d" (data) : "a" (port));
}
unsigned short port_word_in(unsigned short port){
  unsigned short result;
  __asm__ ("in %%dx,%%ax" : "=a" (result) : "d" (port));
  return result;
}
unsigned short port_word_out(unsigned short port, unsigned short data){
  __asm__ ("out %%ax,%%dx" : "=d" (data) : "a" (port));
}
