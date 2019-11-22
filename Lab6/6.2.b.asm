
; Standard header:
	#make_COM#
        ORG  100H  

START_MEM EQU 0000h
END_MEM EQU 0FFFDh
; Jump to start:
	JMP START

START:
;initialization of memory locations
mov SI, START_MEM ; pointing to the start of DS
mov DS: WORD PTR [SI], 0AAAAh
mov DI, END_MEM ; pointing to the end of the ES
mov ES : WORD PTR [DI], 0BBBBh
mov DX, ES: WORD PTR [DI] 

movsw ; copy word from DS: [SI] to ES:[DI]; 
      ; SI  = SI + 2, DI = DI + 2
mov SI, START_MEM
mov DS: [SI], DX

; ES: [DI] = AAAAh
; DS: [SI] = BBBBh