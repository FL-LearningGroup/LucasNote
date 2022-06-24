#include <REGX52.H>
#include "LCD1602.h"

void main()
{
	LCD_Init();
	LCD_ShowChar(1,1,'A');
	LCD_ShowString(1,3,"Hello,World");
	LCD_ShowNum(1,15,23,2);
	LCD_ShowSignedNum(2,1,-93,2);
	LCD_ShowHexNum(2,5,0xA8,2);
	LCD_ShowBinNum(2,8,0xAA,8);
	
	while(1)
	{
		
	}
}