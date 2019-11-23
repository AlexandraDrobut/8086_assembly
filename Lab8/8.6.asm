.data
MSG DB "test", 00h
SEARCH DB "test", 00h
.code

jmp main

strlen proc near
	push si
	mov ax, @data
	mov ds, ax
	xor cx, cx
	cld
next:
	lodsb
	cmp al, 00h
	je finish
	inc cx
	jmp next
finish:	
	pop si
	ret
strlen endp
	
search_p proc near
	push si
	push di
	mov ax, @data
	mov ds, ax
	mov dl, 0FFh
	call strlen ; now we have in cx the length of string
	cld
next_byte:
	lodsb; AL = DS:[SI]
	scasb; cmp al with ES:[di]
	jne finish_p
	loop next_byte
	mov dl, 01h
finish_p:
	ret
search_p endp	
	
store proc near
	push si
	push di
	call strlen
	push cx
	rep 
	movsb
	pop cx
	pop di
	pop si
	ret
store endp
main:
	lea DI, MSG
	lea SI, SEARCH
	call store
	call search_p
	hlt