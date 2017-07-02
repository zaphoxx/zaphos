[bits 32]
VIDEO_MEMORY equ 0xb8000
COLOR equ 0x0f

prints_pm:
  pusha
  xor eax,eax
  mov edx,VIDEO_MEMORY

prints_pm_loop:
  mov al,byte [ebx]
  mov ah,COLOR

  cmp al,0x0
  je prints_pm_exit

  mov [edx], ax
  inc ebx
  add edx,0x2

  jmp prints_pm_loop

prints_pm_exit:
  popa
  ret

prints_pm_end:
  ; marker
