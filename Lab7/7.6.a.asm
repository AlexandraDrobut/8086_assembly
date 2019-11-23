; fit all segments in one 64 kb segment
.model small
;assume the size of the stack of 16 bytes
.stack 10h
.data
ARR_OFF EQU 0100h
NO_BYTES DW 0Ah
.code
jmp main

reset_regs macro
	xor ax,ax
	xor bx,bx
	xor cx,cx
	xor dx,dx
endm

sum proc near
	mov ax, @data
	mov ds, ax
	xor dx,dx
	xor ax, ax
	cld
loc:
	lodsb
	cbw
	add dx, ax
	loop loc
	mov ax, dx
	ret
sum endp

main:
	reset_regs
	mov cx, 000Ah
	mov si, ARR_OFF
	push cx
	push si
;for test initialize the 10 bytes with 10=0Ah
init:
	mov DS:[SI], 0Ah
	inc si
	loop init
	pop si
	pop cx
	call sum
	hlt
