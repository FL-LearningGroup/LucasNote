#include <INTRINS.H>
#include "TimeDelay.h"

void Delay1ms_12MHz(unsigned int xms)		//@12.000MHz
{
	do 
	{
		unsigned char i, j;

		i = 12;
		j = 169;
		do
		{
			while (--j);
		} while (--i);
	}while (--xms);
}