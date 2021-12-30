data segment
    buffer db 20 dup(0)
ends

code segment
jmp start
    ; Print procedure: int 10h , AH = 0Eh Teletype Output

print proc near
    mov ah, 0Eh
    lea si, buffer
    next_b:
        lodsb
        cmp al, 0
        je fin
        int 10h
        jmp next_b
    fin:
        ret
print endp

; Read from keyboard procedure, int 21h, AH=01h
read_char proc near
    mov ah, 01h
    int 21h
    ret
read_char endp

start:
    xor ax, ax
    xor bx, bx
    xor cx, cx
    xor dx, dx
    lea di, buffer
    next_byte:
        call read_char
        cmp al, 0Dh
        je exit:
        stosb
    jmp next_byte

    exit:
        call print

ends

end start ; set entry point and stop the assembler.
