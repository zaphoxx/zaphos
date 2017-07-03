; ### delay(ax) ###
delay:
pusha
	loopAX:
	nop
	mov bx,0x000f
	loopBX:
		nop
		mov cx,bx
		loopCX:
			nop
			dec cx
			cmp cx,0x0
			jnz loopCX
		dec bx
		cmp bx,0x0
		jnz loopBX
	dec ax
	cmp ax,0x0
	jnz loopAX		
popa
ret