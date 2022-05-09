	.file	"harimain.c"
	.intel_syntax noprefix
	.text
	.globl	HariMain
	.type	HariMain, @function
HariMain:
.LFB0:
	.cfi_startproc
	endbr64
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	mov	DWORD PTR -12[rbp], 10
	mov	DWORD PTR -8[rbp], 20
	mov	edx, DWORD PTR -12[rbp]
	mov	eax, DWORD PTR -8[rbp]
	add	eax, edx
	mov	DWORD PTR -4[rbp], eax
	nop
	pop	rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	HariMain, .-HariMain
	.ident	"GCC: (Ubuntu 9.3.0-17ubuntu1~20.04) 9.3.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	 1f - 0f
	.long	 4f - 1f
	.long	 5
0:
	.string	 "GNU"
1:
	.align 8
	.long	 0xc0000002
	.long	 3f - 2f
2:
	.long	 0x3
3:
	.align 8
4:
