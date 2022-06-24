#ifndef __DigitalTube_H__
#define __DigitalTube_H__
#include <REGX52.H>

sfr DigitalTubeSegment = 0x80;
sbit DigitalTubeSelect_0 = 0xA2;
sbit DigitalTubeSelect_1 = 0xA3;
sbit DigitalTubeSelect_2 = 0xA4;

//Declare Arabic numerals(0-9).
//The digital tube is a common cathode.
static unsigned char ARABIC_NUMBER[10] = {0x3f,0x06,0x5b,0x4f,0x66,0x6d,0x7d,0x07,0x7f,0x67};

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

void initialization();

// Compiler error
//*** ERROR L107: ADDRESS SPACE OVERFLOW
//    SPACE:   DATA    
//    SEGMENT: ?DT?DIGITALTUBE
//    LENGTH:  004AH

//typedef struct DigitalTube_Type {
//	void (*initialization)();
//	void (*clearDigitalTube)();
//	void (*DigitalTubeDecDigit[8])();
//	unsigned char ARABIC_NUMBER[10];
//} DigitalTubeObject;

//static DigitalTubeObject DigitalTube = {
//	initialization,
//	clearDigitalTube,
//	{setSingleDigit, setTenDigit, setHundredDigit, setThousandDigit, setTenThousandDigit, setHundredThousandDigit, setMillionDigit, setTenMillionDigit},
//	{0x3f,0x06,0x5b,0x4f,0x66,0x6d,0x7d,0x07,0x7f,0x67},
//};

//Test code
void DigitalTubeTest();
#endif