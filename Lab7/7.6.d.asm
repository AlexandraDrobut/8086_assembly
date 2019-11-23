.code
OFFSET_INIT EQU 100h
OFFSET_DEST EQU 200h
SHIFT_DEST EQU 104h
NO_BYTES EQU 0Ah
jmp main

reset_regs MACRO 
	xor ax,ax
	xor bx,bx
	xor cx,cx
	xor dx,dx
endm

main:
	reset_regs
	mov cx, NO_BYTES
	mov si, OFFSET_INIT
	push cx
	push si
;for test initialize the 10 bytes with 10=0Ah
	mov al, 10d
init:
	mov DS:[SI], al
	inc si
	dec al
	loop init
	pop si
	pop cx
	call redo
	hlt
	
redo proc near
	;store in ES: [DI] the string
	mov DI, OFFSET_DEST
	rep
	movsb
	mov DI, OFFSET_DEST
	mov SI, SHIFT_DEST	
	mov cx, 10d
copy:
	mov al, ES: BYTE PTR [DI]
	mov DS: BYTE PTR [SI], al
	inc di
	inc si
	loop copy
	ret
redo endp

