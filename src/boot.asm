[ORG 0x7c00]			;  BIOS likes always to load the boot sector to the address 0x7c00
; mov [BOOT_DRIVE],dl
; prepare stack and pointers
;mov bp,0x9000
;mov sp,bp
mov bx, BANNER
call prints
mov bx, RM_MSG
call prints

call switch_to_pm

; ### loop ###
jmp $

; ### include external files ###
%include "./src/prints_pm.asm"
;%include "./src/printhex.asm"
;%include "./src/disk_load.asm"
%include "./src/prints.asm"
%include "./src/switch_to_pm.asm"
%include "./src/gdt.asm"

[bits 32]
BEGIN_PM:
	mov ebx,PM_MSG

	jmp $
	;call prints_pm
; ### Variables ###
BANNER			db '### zaphOS v0.1a (experimental) ###',0x0d,0x0a,0x00
RM_MSG			db '[+] starting in realmode [16bits]',0x0d,0x0a,0x00
PM_MSG			db '[+] successfully switched to protected mode [32bits]',0x00
;BOOT_DRIVE  db 0x0
; define end of boot sector
; ##################################################################################
times 510-($-$$) db 0 ; pad bootsector with zeros
dw 0xaa55		; last two bytes form the magic numbers indicating end of bootsector
; ##################################################################################

;times 256 dw 0xdead
;times 256 dw 0xbeef
