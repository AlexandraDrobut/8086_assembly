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
;!!!mov cx, 8 should have been
;written outside the loop
;the idea behind the correct version
;is to create a softare delay
call delay
hlt

delay PROC NEAR

; assuming a microprocessor with
; F = 10 MHz => Tck = 0,1 us

;delay using nop and loop
; Tck nop = 3 Tck = 3 * 0,1 us = 0,3 us
; Tck loop = 17 Tck = 1,7 us

; N_count = T delay / Tck_instr * Tck
; N_count = 1 * 10^(-3) s/ 20 Tck * 0,1 us
; N_count = 10 ^(-3)/ 20 * 0, 1 * 10 ^(-6)s
; N_count = 0,5 * 10 ^ 3 = 500
;1 ms dely
mov cx, 500d
for_ms:
	nop
	loop for_ms
; N_count = 1 s/ 2 * 10 ^ (-6) = 0, 5 * 10 ^ 6 = 50 000 
; 1 s delay
mov cx, 50 000d

for_s: 
	nop
	loop for_s
	ret
delay endp
	


