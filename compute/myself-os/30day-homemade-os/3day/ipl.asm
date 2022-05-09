; haribote-ipl
; TAB=4

    CYLS	EQU		18		; 声明CYLS=10类似于#define CYLS 10， 设置加载10个柱面，一张软盘有80个柱面，2个磁头，18个扇区，且一个扇区有512个字节。
    ORG		0x7c00			; 指明程序装载地址,ref(http://www.ruanyifeng.com/blog/2015/09/0x7c00.html)

; 标准FAT12格式软盘专用的代码 Stand FAT12 format floppy code

    JMP		entry           ; jump to entry(JMP = 0xeb, entry = 0x4e)
    DB		0x90            ; FAT12 固定数值
    DB		"HARIBOTE"		; 启动扇区名称（必须为8字节）
    DW		512				; 每个扇区（sector）大小（必须512字节）
    DB		1				; 簇（cluster）大小（必须为1个扇区）
    DW		1				; FAT起始位置（一般为第一个扇区）
    DB		2				; FAT个数（必须为2）
    DW		224				; 根目录大小（一般为224项）
    DW		2880			; 该磁盘大小（必须为2880扇区1440*1024/512）
    DB		0xf0			; 磁盘类型（必须为0xf0）
    DW		9				; FAT的长度（必??9扇区）
    DW		18				; 一个磁道（track）有几个扇区（必须为18）
    DW		2				; 磁头数（必??2）
    DD		0				; 不使用分区，必须是0
    DD		2880			; 重写一次磁盘大小
    DB		0,0,0x29		; 意义不明（固定）
    DD		0xffffffff		; （可能是）卷标号码
    DB		"HARIBOTEOS "	; 磁盘的名称（必须为11字，不足填空格）
    DB		"FAT12   "		; 磁盘格式名称（必需为8字?，不足填空格）
    TIMES	18 DB 0x00				; 先空出18字节

; 程序主体
entry:
    MOV     AX,0   ;初始化寄存器
    MOV     BX,0
    ; 构造栈SS:
    MOV     SS,AX   
    MOV     SP,0x7c00 ; 设置栈区间栈的最大地址为0x7c00
    MOV     DS,AX   ;  设置DS=0，可以直接使用[adress]代表地址。Address = DS x 16 + [number] => Address = [number]
    MOV     AX,0x0820    
    MOV     ES,AX   ; 设置磁盘缓冲区地址，也就是我们要把从软盘读出的数据装载到内存的位置。ES x 16 + BX=0x8200
    MOV     CH,0    ;柱面0
    MOV     DH,0    ;磁头0
    MOV     CL,2    ;扇区2

readloop:
    MOV     SI,0    ;记录失败次数的寄存器

retry:
    MOV     AH,0x02 ; 读盘设置，（AH = 0x03 写盘设置）
    MOV     AL,1    ; 1个扇区，设置处理对象的扇区数
    MOV     BX,0    ; ES:BX 缓冲地址
    MOV     DL,0x00     ;A驱动
    INT     0x13        ;启用中断，调用磁盘BIOS
    JNC     next        ;CF = 0， 没有出错则跳转到next
    ADD     SI,1        ;出错SI加1
    CMP     SI,5        ;比较出错次数达到5次
    JAE     error       ; SI >= 5 跳转到error
    MOV     AH,0x00
    MOV     DL,0x00     ;A驱动器
    INT     0x13
    JMP     retry
next:
    MOV     AX,ES       ;把内存地址后移0x200(512/16)
    ADD     AX,0x0020
    MOV     ES,AX       ;ADD ES,0x020因为不能ADD ES
    ADD     CL,1
    CMP     CL,18
    JBE     readloop
    MOV     CL,1
    ADD     DH,1
    CMP     DH,2
    JB      readloop
    MOV     DH,0
    ADD     CH,1
    CMP     CH,CYLS
    JB      readloop
    ;跳转到sysinit
    MOV     [0x0ff0],CH
    JMP     0x8200

error:
    MOV     SI,errormsg

putloop:
    MOV     AL,[SI]
    ADD     SI,1
    CMP     AL,0
    JE      fin
    MOV     AH,0x0e
    MOV     BX,15
    INT     0x10        ;调用显卡BIOS
    JMP     putloop

fin:
    HLT     ; 让CPU停止，等待指令
    JMP     fin ; 无限循环

errormsg:
    DB      0x0a,0x0a
    DB      "load,error"
    DB      0x0a
    DB      0

    TIMES    510-($-$$) DB 0x00    ; ref:https://zhuanlan.zhihu.com/p/353391541

    DB      0x55,0xaa