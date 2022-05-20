section .text
    global _start

_start:
    mov edx, len
    mov ecx, msg
    mov ebx, 1
    mov eax, 4
    int 0x80

    mov eax, 1
    int 0x80

section .data
msg db 'Hello, world!', 0xa
len equ $ - msg

; Compile
; nasm -f elf helloworld.asm
; ld -m elf_i386 -s -o hello helloworld.o

; Run
; ./hello
; Hello, world!