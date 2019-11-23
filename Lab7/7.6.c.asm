; fit all segments in one 64 kb segment
.model small
;assume the size of the stack of 16 bytes
.stack 10h
.data
OFFSET_INIT EQU 100h
OFFSET_DEST EQU 200h
NO_BYTES EQU 0Ah
.code

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
;INIT 10 BYTES WITH 10 DIFFERENT VALUES
	mov DS:[SI], al
	inc si
	dec al
	loop init
	pop si
	pop cx

; create array	
	mov bx, OFFSET_DEST
	
	cld
fill_array:
	lodsb
	mov DS: BYTE PTR[bx], al
	mov DS: BYTE PTR [bx + 1] , 00h
	add bx, 2
	loop fill_array
	hlt

; DS:[200] = AA 00 99 00 .. 11 00