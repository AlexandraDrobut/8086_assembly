DATA SEGMENT
	org 100h
	ARR_1 DB 10 DUP('A')
DATA ENDS

CODE SEGMENT
	mov DI, 0200h
	mov cx, 000Ah
init_es:
	push cx
fill:
	mov ES:[DI], 'B'
	inc di
	loop fill
	pop cx
	lea SI, ARR_1
	mov DI, 0200h
	call create_diff_set
	hlt
	
create_diff_set proc near
	cld
	mov ax, @data
	mov ds, ax
	mov es, ax
	xor ax, ax
	xor dx, dx
	mov bx, di
	mov di, 0300h
next_byte:
	lodsb
	sub al, ES: BYTE PTR[BX]
	inc bx
	stosb
	loop next_byte
	ret
create_diff_set endp
CODE ENDS