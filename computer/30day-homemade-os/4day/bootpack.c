/* 告诉C编译器，有一个函数在别的文件里 */

extern void io_hlt(void);
extern void write_mem8(int addr, int data);

/* 是函数声明却不用{}，而用;，这表示的意思是：
	函数在别的文件中，你自己找一下 */

void _start(void)
{
	int i;
	for(i = 0xa0000; i <= 0xaffff; i++)
	{
		write_mem8(i, i & 0x0f);
	}
	for(;;)
	{
		io_hlt(); /* 执行naskfunc.nas中的_io_hlt函数 */
	}
}