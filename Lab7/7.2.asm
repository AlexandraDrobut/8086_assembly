#make_COM#

; COM file is loaded at CS:0100h
ORG 100h
jmp start

reset_regs MACRO
xor ax, ax
xor bx, bx
xor cx, cx
xor dx, dx
ENDM

start:

reset_regs
mov al, 67h
mov cl, 08h
push ax
reverse:
	shl ax, 1
	rol ah, 1
	shr ah, 1
	loop reverse

pop dx
mov al, dl
hlt
; AX = 6767h

