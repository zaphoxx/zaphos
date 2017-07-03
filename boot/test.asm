[BITS 16]
[ORG 0x7c00]

mov dx,0xdead
mov dx,0xbeef
xor cx,cx
xor ax,ax
mov ax,0x000f
mov cx,0x3
push dx
loop:
mov di,dx
and di,ax
mov di,[digits+di]
mov si,cx
mov [hexOut+si+2],di
shr dx,4
dec cl
jnz loop
mov bx,hexOut
;call prints

hexOut db '0x0000',0
digits db '0123456789abcdef'


