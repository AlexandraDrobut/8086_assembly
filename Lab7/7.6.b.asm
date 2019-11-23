; fit all segments in one 64 kb segment
.model small
;assume the size of the stack of 16 bytes
.stack 10h
.code
jmp main

reset_regs macro 
	xor ax,ax
	xor bx,bx
	xor cx,cx
	xor dx,dx
endm

min proc near
	mov ax,@data
	mov ds, ax
	xor bx, bx; hold minimum in bl
	xor dx, dx ; hold index in dx
	mov bl, DS : BYTE PTR [SI]
	mov dx, SI
for:
	lodsb
	cmp al, bl
	jge increment
	;if al min store in bl
	mov bl, al
	mov dx, si
increment:
	loop for
	mov al, bl
	mov si, dx
	ret
min endp

main:
	reset_regs
	mov cx, 000Ah
	mov si, 0100h
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
	call min
	hlt

;At the end AL = 00h