; naskfunc
; TAB=4
; 以下是实际的函数
SECTION .text		; 目标文件中写了这些后再写程序
	GLOBAL	io_hlt		; 程序中包含的函数名

io_hlt:			; void io_hlt(void);
		HLT
		RET
