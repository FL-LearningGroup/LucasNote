assume cs:abc

abc segment

    mov ax,2
    mov ax,ax
    mov ax,ax

    mov ax,4c00H
    int 21H

abc ends

end