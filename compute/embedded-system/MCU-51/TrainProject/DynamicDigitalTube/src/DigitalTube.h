#ifndef __DigitalTube_H__
#define __DigitalTube_H__
#include <REGX52.H>

sfr DigitalTubeSegment = 0x80;
sbit DigitalTubeSelect_0 = 0xA2;
sbit DigitalTubeSelect_1 = 0xA3;
sbit DigitalTubeSelect_2 = 0xA4;

//Declare Arabic numerals(0-9).
//The digital tube is a common cathode.
static char ARABIC_NUMBER[] = {0x3f,0x06,0x5b,0x4f,0x66,0x6d,0x7d,0x07,0x7f,0x67};

//Declare decimal counting unit
void setSingleDigit();
void setTenDigit();
void setHundredDigit();
void setThousandDigit();
void setTenThousandDigit();
void setHundredThousandDigit();
void setMillionDigit();
void setTenMillionDigit();

static void (*DigitalTubeDecDigit[])() = {setSingleDigit, setTenDigit, setHundredDigit, setThousandDigit, setTenThousandDigit, setHundredThousandDigit, setMillionDigit, setTenMillionDigit};
	
void clearDigitalTube();

//Test code
void DigitalTubeTest();
#endif