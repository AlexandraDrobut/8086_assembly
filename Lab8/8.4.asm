STACK SEGMENT
	DW 10 DUP (?)
STACK ENDS

DATA SEGMENT PARA PUBLIC 'DATA'

ARRAY DB 20h, 0Ah, 35h, 90h, 0Ah

DATA ENDS

CODE SEGMENT PARA PUBLIC 'CODE'
jmp main

reset_regs macro
	xor ax,ax
	xor bx,bx
	xor cx,cx
	xor dx,dx
endm

main:
	lea si, ARRAY
	mov cl, 5d
	call substitute
	hlt

substitute proc near
	mov ax, DATA
	mov ds, ax
	mov al, 0Ah ; value to be compared
	mov bl, 0BBh ; value with which to be replaced
	mov dl, al
	cld
for:
	lodsb
	cmp dl , al
	jnz next
	mov DS: BYTE PTR [si - 1], bl
next:
	loop for
	ret
substitute endp
CODE ENDS