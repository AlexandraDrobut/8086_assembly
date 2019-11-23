DATA SEGMENT PARA PUBLIC 'DATA'
	org 100h
	ARR_1 DB 10 DUP('A')
DATA ENDS

CODE SEGMENT PARA PUBLIC 'CODE'
	mov SI, offset ARR_1
	mov DI, 0300h
	mov cx, 000Ah
	call create
	hlt
	
create proc near
	cld
	xor ax, ax
	xor dx, dx
next_byte:
	lodsb
	stosb
	mov ES : BYTE PTR [DI], 00h
	inc DI
	loop next_byte
	ret
create endp
CODE ENDS