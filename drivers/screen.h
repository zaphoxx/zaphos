#ifndef _SCREEN_H
#define _SCREEN_H
#define VIDEO_ADDRESS 0xb8000   // vga video memory startaddress
#define MAX_ROWS 25
#define MAX_COLS 80
#define COLOR 0x0f              // default colorscheme white on black

#define SCREEN_CTRL 0x3d4
#define SCREEN_DATA 0x3d5

enum color{
  black,
  blue,
  green,
  cyan,
  red,
  magenta,
  brown,
  lightgrey,
  darkgrey,
  lightblue,
  lightgreen,
  lightcyan,
  lightred,
  lightmagenta,
  lightbrown,
  white
};

#endif
