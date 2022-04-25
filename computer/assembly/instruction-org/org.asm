org 100h
jmp     start
welcome: db 'welcome Lucas OS', '$'

start:
    mov si, welcome
    call printstr
    ret

printstr:
    mov al, [si]
    cmp al, '$'
    je disover
    mov ah, 0eh
    int 10h
    inc si
    jmp printstr

disover:
    ret