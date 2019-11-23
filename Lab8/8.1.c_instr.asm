
.data
	org 100h
	ARR_1 DB 10 DUP('A')

.code
	mov SI, offset ARR_1
	mov DI, 0200h
	mov cx, 000Ah
	push cx
	push di
init_es:
	mov al, 'b'
	rep
	stosb
	pop cx
	pop di
	call intersect
	hlt
	
intersect proc near
	mov ax, @data
	mov ds, ax
	mov es, ax
	cld
	xor ax, ax
	xor dx, dx
	mov bx, di
	mov di, 0300h
next_byte:
	lodsb
	call search
	cmp dx, 0001h
	jnz next
	stosb
next:
	loop next_byte
	ret
sum endp

search proc near

	push di
	push cx
	lea di, ARR_2
	cld
next:
	scasb
	jz found	
	loop next
	jmp finish		
found:
	mov dx,1h
finish:
	pop di
	pop cx
	ret
search endp