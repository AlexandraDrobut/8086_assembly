
.code
	mov SI, offset ARR_1
	mov DI, 0200h
	mov cx, 000Ah
	push si
	push cx
	mov al, 'b'
	rep
	stosb
	pop si
	pop cx
	call sum
	hlt
	
sum proc near
	mov ax, @data
	mov ds, ax
	mov es, ax
	cld
	xor ax, ax
	xor dx, dx
next_byte:
	mov al, DS : BYTE PTR[SI]
	mul ES : BYTE PTR [DI]
	add dx, ax
	inc DI
	inc si
	loop next_byte
	mov ax, dx
	ret
sum endp

.data
	org 100h
	ARR_1 DB 10 DUP('A')
