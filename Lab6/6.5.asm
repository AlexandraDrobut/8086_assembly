
; Standard header:
	#make_COM#
        ORG  100H  
	JMP START
DEST_OFFSET DW 108h
START:
mov BX , 100h
mov SI, 104h
mov DS: DWORD PTR [BX], 11223344h
mov DS: DWORD PTR [SI], 55667788h
mov SI, DEST_OFFSET
mov AX, DS: WORD PTR [BX]
add AX, DS: WORD PTR [SI]
mov BX, WORD PTR [ BX + 2]
add BX, DS: WORD PTR [SI + 2]

; store sum
mov SI, DEST_OFFSET
mov DS: WORD PTR [SI], AX
mov DS: WORD PTR [SI + 2], BX

; DS content:
; [100] 11223344
; [104] 55667788
; [108] 6688AACC