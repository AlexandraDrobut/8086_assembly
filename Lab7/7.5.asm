jmp start

reset_regs MACRO
	xor ax, ax
	xor bx, bx
	xor cx, cx
	xor dx, dx
ENDM

start:
reset_regs
mov al, 66h
mov bl, 77h
mov cl, 88h
call max 
hlt

max proc near
	cmp al, bl
	jge cmp_al_cl
	cmp bl, cl
	jle max_cl
	mov al, bl
	jmp max_ret
cmp_al_cl:
	cmp al, cl
	jle max_cl
max_cl:
	mov al, cl
max_ret:
	ret
max endp
