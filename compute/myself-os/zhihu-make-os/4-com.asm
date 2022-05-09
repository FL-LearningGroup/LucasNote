%define   com              ; 注释用于MBR，不注释用于COM调试
%ifdef    com
orgaddr   equ   100h       ;用于COM调试的设置
%else
orgaddr   equ   7c00h      ;用于MBR启动的设置
%endif


jmp start

welcome db 'Welcome Jiang OS','$'

start:
mov ax, cs
add ax, orgaddr/10h
mov ds, ax
mov es, ax

mov  si, welcome
call printstr

%ifdef    com           ;如果是.COM调试，需要调用DOS返回中断
mov ah,4ch
int 21h
%endif                  ;.COM程序将在此顺利返回Dos系统

jmp $                   ;如果是MBR启动，将在此停止运行


printstr:                  ;显示指定的字符串, 以'$'为结束标记
      mov al,[si]
      cmp al,'$'
      je disover
      mov ah,0eh
      int 10h
      inc si
      jmp printstr
disover:
      ret

times 510-($-$$) db 0
      db 0x55,0xaa