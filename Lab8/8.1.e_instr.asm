DATA SEGMENT
	org 100h
	ARR_1 DB 0Ah, 09h, 08h, 07h, 06h, 05h, 04h, 03h, 02h, 01h
DATA ENDS
CODE SEGMENT
reset_regs macro
	xor ax, ax
	xor bx, bx
	xor cx, cx
	xor dx, dx
endm

start:
	reset_regs
	mov SI, offset ARR_1
	mov DI, 0300h
	mov cx, 000Ah
	call create_reverse
	hlt
	
create_reverse proc near
	cld
	mov ax, @data
	mov ds, ax
	mov es, ax
	xor ax, ax
	add SI, 0Ah
next_byte:
	std
	lodsb
	cld
	stosb
	loop next_byte
	ret
create_reverse endp

CODE ENDS