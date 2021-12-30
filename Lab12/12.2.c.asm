DATA    SEGMENT        PARA    PUBLIC    'DATE'
n1bin   DB    0
n2bin   DB      0
sumasc  DB      3 DUP(?)
errmsg  DB      'Try again!Err lin com',0
DATA    ENDS
;
; Code segment
;-----------------
;
CODE    SEGMENT        PARA    PUBLIC    'COD'

MAIN    PROC        FAR
    ASSUME        SS:STIVA,DS:DATA,CS:CODE,ES:NOTHING

    push    ds
    xor    ax,ax
    push    ax        ;preg.pt.ret
    ;
    mov    ax,DATA
    mov    ds,ax        ;preg. DS
    call    verify
    cmp    ax,0
    jz    ok
    ret
    ;get the first number in the command line from PSP
    ok:    mov    dh,es:[82h]
    mov    dl,es:[83h]    ; DX contains the two bytes
    ; from the PSP in ASCII
    call    convab        ; convert ASCII-BINARY
    ; BL contains the first number in binary
    mov    [n1bin],bl    ; store the first number
    ;get the second number in the command line from PSP
    mov    dh,es:[85h]
    mov    dl,es:[86h]    ;DX contains the second number in ASCII
    call    convab
    mov    [n2bin],bl    ;store the second number
    ;add the two numbers
    xor     ah,ah
    mov     al,[n1bin]
    sub    al,bl        ;al<--[n1bin]-[n2bin]
    ;prepare for display
    call    convba        ;convert the number from AL into ASCII
    ;
    call    disprez        ;display result
    ret
MAIN    ENDP

; Procedures
;----------------
;Check if the command line is correct
;
VERIFY    PROC    NEAR
    mov    al,es:[80h]
    cmp     al,6
    jnz    traterr
    mov    al,es:[81h]
    cmp    al,' '
    jnz    traterr
    mov    ax,es:[82h]
    and    ax,0f0f0h
    cmp    ax,3030h
    jnz    traterr
    mov    al,es:[84h]
    cmp al,'-'
    jnz    traterr
    mov    ax,es:[85h]
    and    ax,0f0f0h
    cmp     ax,3030h
    jnz    traterr
    mov     ax,0
    ret
    traterr:
    mov     si,offset errmsg
    mov     bh,0
    mov     bl,0
    mov    ah,0eh
    iar:    lodsb
    cmp    al,0
    jz    stop
    int    10h
    jmp    iar
    stop:    mov    ax,0ffffh
    ret
VERIFY  ENDP
;convert from ASCII to binary
;
convab    PROC    NEAR
    xor     ah,ah
    mov     cl,10
    and     dx,0f0fh    ;store the significant digits
    mov     al,dh
    mul     cl
    mov     bl,al    ; tens are stored in BL
    add     bl,dl    ; move to BL the binary number
    ret
convab    ENDP
;
;convert from binary to ASCII
;
convba    PROC    NEAR
    xor    ah,ah    ;AH=0 , AL = the number
    mov    cl,10
    div    cl    ;
    add     ah,30h    ;decimal--->ASCII
    mov    [sumasc+2],ah    ; units digit
    ;
    xor    ah,ah
    div    cl
    add    ah,30h
    mov    [sumasc+1],ah    ; tens digit
    ;
    add    al,30h
    mov    [sumasc],al    ; hundreds digit
    ;
    ret
convba    ENDP
;
;display the result
;
disprez    PROC    NEAR
    mov    bh,0
    mov    dx,11*256+1
    mov    ah,0eh    ;teletype mode
    ;
    mov    al,es:[82h]
    int    10h
    mov     al,es:[83h]
    int     10h        ;display the first number
    mov     al,'-'
    int    10h
    mov     al,es:[85h]
    int    10h
    mov    al,es:[86h]    ;display the second number
    int    10h
    mov    al,'='
    int    10h
    mov     al,[sumasc]
    cmp    al,'0'
    jz    nosute
    int    10h
    nosute:    mov    al,[sumasc+1]
    int    10h
    mov    al,[sumasc+2]
    int    10h        ;display the sum
    ret
    ;
disprez ENDP
;
CODE    ENDS
END    MAIN




; [SOURCE]: C:\Users\rvbdadmin\Downloads\211213_Lab12\211213_Lab12\ADUNARE.ASM
