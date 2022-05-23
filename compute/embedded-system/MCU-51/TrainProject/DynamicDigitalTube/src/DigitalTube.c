#include <REGX52.H>
#include "DigitalTube.h"
#include "TimeDelay.h"

void setSingleDigit()
{
	DigitalTubeSelect_0 = 0;
	DigitalTubeSelect_1 = 0;
	DigitalTubeSelect_2 = 0;
}

void setTenDigit()
{
	DigitalTubeSelect_0 = 1;
	DigitalTubeSelect_1 = 0;
	DigitalTubeSelect_2 = 0;
}
	
void setHundredDigit()
{
	DigitalTubeSelect_0 = 0;
	DigitalTubeSelect_1 = 1;
	DigitalTubeSelect_2 = 0;
}

void setThousandDigit()
{
	DigitalTubeSelect_0 = 1;
	DigitalTubeSelect_1 = 1;
	DigitalTubeSelect_2 = 0;
}

void setTenThousandDigit()
{
	DigitalTubeSelect_0 = 0;
	DigitalTubeSelect_1 = 0;
	DigitalTubeSelect_2 = 1;
}

void setHundredThousandDigit()
{
	DigitalTubeSelect_0 = 1;
	DigitalTubeSelect_1 = 0;
	DigitalTubeSelect_2 = 1;
}

void setMillionDigit()
{
	DigitalTubeSelect_0 = 0;
	DigitalTubeSelect_1 = 1;
	DigitalTubeSelect_2 = 1;
}
void setTenMillionDigit()
{
	DigitalTubeSelect_0 = 1;
	DigitalTubeSelect_1 = 1;
	DigitalTubeSelect_2 = 1;
}

void clearDigitalTube()
{
	Delay1ms_12MHz(200);
	DigitalTubeSegment = 0x00;
}

void DigitalTubeTest()
{
	unsigned int i;
	unsigned int j;
	clearDigitalTube();
	Delay1ms_12MHz(600);
	DigitalTubeDecDigit[0]();
	//Display 0 - 9
	for(i = 0; i < 10; i++)
	{
		DigitalTubeSegment = ARABIC_NUMBER[i];
		Delay1ms_12MHz(400);
	}
	//Select digit
	for(j = 1; j < 9; j++)
	{
		DigitalTubeDecDigit[j]();
		Delay1ms_12MHz(400);
	}
}
