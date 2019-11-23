DATA SEGMENT
	org 0100h
	ARR_1 DB 01h, 02h, 03h, 04h, 05h, 06h, 07h, 08h, 09h, 0Ah
DATA ENDS
CODE SEGMENT
	mov SI, 0100h
	mov DI, 0200h
	mov cx, 000Ah
	push di
	push cx
	mov al, 01h
init_es:
	rep 
	stosb
	pop di
	pop cx
	call intersect
	hlt
	
intersect proc near
	cld
	xor ax, ax
	xor dx, dx
	mov bx, di
	mov di, 0300h
next_byte:
	mov al, DS: BYTE PTR [SI]
	call search
	cmp dx, 0001h
	jnz next
	mov ES: [DI], al
	inc di
next:
	inc si
	loop next_byte
	ret
intersect endp

search proc near

	push di
	push cx
	mov di, 0200h
	cld
next_b:
	cmp al, ES: BYTE PTR [DI]
	je found
	inc di	
	loop next_b
	jmp finish		
found:
	mov dx,1h
finish:
	pop di
	pop cx
	ret
search endp
CODE ENDS
