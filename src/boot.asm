; a boot sector that enters 32-bit protected mode
[ORG 0x7c00]			;  BIOS likes always to load the boot sector to the address 0x7c00
KERNEL_OFFSET equ 0x1000
	mov ax,0
	mov es,ax
	mov [BOOT_DRIVE],dl
	mov bp,0x9000
	mov sp,bp
	mov bx, BANNER
	call prints
	mov bx, RM_MSG
	call prints

	call load_kernel
	mov bx, BANNER
	call prints
	call switch_to_pm

	jmp $
	
%include "./src/disk_load.asm"
%include "./src/prints.asm"
%include "./src/gdt.asm"
%include "./src/switch_to_pm.asm"

%include "./src/prints_pm.asm"

[bits 16]
load_kernel:
	mov bx,LOAD_KERNEL_MSG
	call prints
	mov bx,KERNEL_OFFSET
	mov dh,15
	mov dl,[BOOT_DRIVE]
	call disk_load
	ret

[bits 32]
BEGIN_PM:
	;call clearVideoBuffer
	;call printColorRange
	mov ebx,PM_MSG
	call prints_pm
	call KERNEL_OFFSET

	jmp $
;	### Variables ###
BOOT_DRIVE	db 0
BANNER			db '### zaphOS v0.1a (experimental) ###',0x0d,0x0a,0x00
RM_MSG			db '[+] starting in realmode [16bits]',0x0d,0x0a,0x00
PM_MSG			db '[+] successfully switched to protected mode [32bits]',0x00
LOAD_KERNEL_MSG db '[+] loading kernel from disk',0x0d,0x0a,0x00
;BOOT_DRIVE  db 0x0
; define end of boot sector
; ##################################################################################
times 510-($-$$) db 0 ; pad bootsector with zeros
dw 0xaa55		; last two bytes form the magic numbers indicating end of bootsector
; ##################################################################################
