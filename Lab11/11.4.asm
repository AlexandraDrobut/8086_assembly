
org 100h
jmp start
message1 db "Please enter the password", "$"
pwd db "pass", 0
pwd_buff db 3 dup(0)
lengthp EQU 4
message2 db "Welcome to the system","$"
message3 db "The access in the system is not allowed","$"

scan_str proc near
    mov bx, 1
    lea di, pwd_buff
    lea si, pwd
    cld
    mov cx, lengthp
    next_char:
        call read_char
        cmp al, 0Dh
        je fin
        stosb
        jz fin
        loop next_char
    fin:
        mov cx, lengthp
        lea si, pwd
        lea di, pwd_buff
        repe cmpsb
        jne exit
        mov bx, 0
    exit:
        ret
scan_str endp

start:

    xor ax, ax
    xor bx, bx
    xor cx, cx
    xor dx, dx
    mov ax , ds
    mov es, ax
    lea dx, message1
    call print_string
    call scan_str
    cmp bx, 0
    jne denied:
    lea dx, message2
    call print_string
    ret

    denied:
        lea dx, message3
        call print_string
ret


; Read from keyboard procedure, int 16h, AH=00h
read_char proc near
    mov ah, 00h
    int 16h
    ret
read_char endp

print_string proc near
    mov ah, 09h
    int 21h
    ret
print_string endp









