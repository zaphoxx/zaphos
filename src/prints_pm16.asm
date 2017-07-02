; ### clear video buffer ###
jmp setConstants

;set videobuffer segment
setVideoBufferSegment:
pusha
mov es,ax
popa
ret

clearScreen:
pusha
mov ax,VIDEOBUFFER
mov es,ax
xor cx,cx
xor di,di
clearVideoBuffer:
mov [es:di],word 0x1100
inc cx
inc di
inc di
cmp cx,	2000
jne clearVideoBuffer
popa
ret
; ### end - clear video buffer ###

; ### prints_pm(bx[,cx]) ### bx - char pointer, cx - offset in videobuffer
prints_pm:
pusha
xor dx,dx
cmp [ROW],byte 0x00
je prints_pm_loop
mov dx,160
mov ax,dx
mul byte [ROW]
mov dx,ax
prints_pm_loop:
xor di,di
xor ax,ax
mov al,[bx]
mov ah,COLOR
cmp al,0x00
je prints_pm_exit
add di,dx
stosw
inc bx
add dx,0x2
jmp prints_pm_loop
prints_pm_exit:
inc byte [ROW]
popa
ret

setConstants:
VIDEOBUFFER equ 0xb800	; address
COLOR		equ 0x1e 	; yellow on blue
COL db 0x00
ROW db 0x00
