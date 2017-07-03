; ### prints(bx) ###
; define simple function to print strings to screen
; expects bx to hold the string to print
prints:
  pusha					; save regs to stack
  mov si,bx
  mov ah,0x0e
printc:
  lodsb
  cmp al,0x00
  je exit_prints
  int 0x10
  jmp printc
exit_prints:
  popa					; restore regs
  ret						; return
