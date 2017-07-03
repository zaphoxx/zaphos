; ### printhex(dx) ###
; print hexnumbers to screen
; expects dl to hold the one byte hexnumber
printhex:
pusha
mov cx,0x0002		; set counter cx=2
get_next_byte:		;
mov ax,dx
cmp cx,0x0
jne skip_swap
xchg al,ah
skip_swap:
mov ah,al
shr ah,4
and al,0x0f
mov bx,digits
xlat
xchg ah,al
xlat
mov si,hexOut
add si,cx
mov [si+2],al
mov [si+3],ah
dec cx
dec cx
jz get_next_byte
lea bx, [hexOut]
call prints_pm
popa
ret

digits: 		db '0123456789abcdef'
hexOut: 		db '0x0000 ',0