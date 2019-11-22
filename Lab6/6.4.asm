
; Standard header:
	#make_COM#
        ORG  100H  
	JMP START

START:
mov AX, 1122h
mov BX, 3344h
mov CX, 5566h
mov DX, 7788h

; (AX, BX) = 11223344h - on 32 bits
; (CX, DX) = 55667788h

add CX, AX
add DX, BX

; (CX, DX) = 6688AACCh