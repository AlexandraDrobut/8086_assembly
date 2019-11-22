#make_COM#

; COM file is loaded at CS:0100h
ORG 100h

;solution without using xlat
; store table in memory at [200h]
org 200h
;lookup table definition
; assuring null-terminator at the end of the table
TABLE DB 30h, 31h, 32h, 33h, 34h, 35h, 36h, 37h, 38h, 39h, 41h, 42h, 43h, 44h, 45h, 46h, 00h
; where to store the lookup value	 
OFFSET DW 0100h
jmp start:

START:

; clearing current state of registers
cli
xor AL, AL
xor BL, BL
xor CL, Cl
xor DL, DL

mov DL , 01Ah
mov SI, OFFSET
lea BX, TABLE
mov AL , DL
;put in al the high nibble of the register
and AL , 0F0h
;assign higher nibble to lower nibble
shr AL, 4
; store value from lookup table in AL
mov AL, [BX + AL] 
; store looked-up value in memory
mov DS: BYTE PTR [SI], AL
inc SI
mov AL, DL
; assign AL with the lowest nibble from DL
and AL, 0Fh
; store value from lookup table 
mov AL, [BX + AL]
; store value in memory
mov DS:BYTE PTR[SI], AL