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
	mov al, DS: BYTE PTR [SI]
	mov ES: BYTE PTR [DI], al
	inc di
	mov ES : BYTE PTR [DI], 00h
	inc si
	inc DI
	loop next_byte
	ret
create endp
CODE ENDS