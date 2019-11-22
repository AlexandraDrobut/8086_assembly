#make_COM#

; COM file is loaded at CS:0100h
ORG 100h

mov ax, 0001h
; executing this instruction will cause an overflow
add bx, 0FFFFh
mov ax, 0000h
add bx, 0FFFFh
