; naskfunc
; TAB=4
; 以下是实际的函数
SECTION .text		; 目标文件中写了这些后再写程序
	GLOBAL	io_hlt		; 程序中包含的函数名
	GLOBAL	write_mem8;

io_hlt:			; void io_hlt(void);
		HLT
		RET

write_mem8:		; void write_mem8(int addr, int data)
		MOV		ECX, [ESP+4]
		MOV		AL, [ESP+8]
		MOV		[ECX], AL
		RET