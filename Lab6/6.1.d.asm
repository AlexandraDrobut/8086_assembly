
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

;shifting the content of the registers
xchg AX, BX ; BX AX CX DX
xchg BX, CX ; BX CX AX DX
xchg CX, DX ; BX CX DX AX

; AX = 3344h
; BX = 5566h
; CX = 7788h
; DX = 1122h