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
mov bx, 0FFEEh
mov cx, 0DDCCh
mov dx, 0BBAAh

mov ah, bh
and ah, 0F0h
shr ch, 4
or ah, ch
mov al, bl
and al, 0F0h
shr dl, 4
or al, dl
hlt
; AX = FDEAh

