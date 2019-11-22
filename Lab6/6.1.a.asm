
; Standard header:
	#make_COM#
        ORG  100H  

OFFSET DW 100h
; Jump to start:
	JMP START

START:
;initialization of registers
mov AX, 1122h
mov BX, 3344h
mov CX, 5566h
mov DX, 7788h

;pointing in Data segment
mov SI, OFFSET
mov DS: WORD PTR [SI], AX

;shifting the content of the registers
mov AX, BX
mov BX, CX
mov CX, DX
mov DX, DS: WORD PTR [SI]

; AX = 3344h
; BX = 5566h
; CX = 7788h
; DX = 1122h
