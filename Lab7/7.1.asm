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
mov al, 0FFh
mov cl, 04h

high_nibble:
	shl ax, 1
	shl ah, 1
	loop high_nibble

mov cl, 04h
mov bl, al
low_nibble:
	shl bx, 1
	shl bh, 1
	loop low_nibble
mov al, bl
hlt
; AX = AAAAh

