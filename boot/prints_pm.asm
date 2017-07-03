[bits 32]
VIDEO_MEMORY equ 0xb8000
COLOR equ 0x1e

jmp $

clearVideoBuffer:
  pusha
  xor ecx,ecx
  mov edx,VIDEO_MEMORY
clearContent:
  xor eax,eax
  mov ax, 0x1100
  cmp ecx,2000
  je clearVideoBuffer_exit
  mov [edx],eax
  inc ecx
  inc edx
  inc edx
  jmp clearContent
clearVideoBuffer_exit:
  popa
  ret

printColorRange:
  pusha
  mov edx,VIDEO_MEMORY
  xor eax,eax
  mov ah,0x00
  loopColors:
  push 'AAAA'
  mov al,byte[esp]
  pop ebx
  cmp ah,0x0f
  jg printColorRange_exit
  mov [edx],eax
  inc edx
  inc edx
  inc ah
  jmp loopColors
  printColorRange_exit:
  popa
  ret

prints_pm:
  pusha
  mov edx,VIDEO_MEMORY
  add edx,160
  mov esi,ebx
prints_pm_loop:
  mov al,byte [esi]
  mov ah,COLOR

  cmp al,0x0
  je prints_pm_exit

  mov [edx], ax
  inc esi
  inc edx
  inc edx

  jmp prints_pm_loop

prints_pm_exit:
  popa
  ret

prints_pm_end:
  ; marker
