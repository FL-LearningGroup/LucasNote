#include "NumberOperator.h"

unsigned char *splitNumber(unsigned int number)
{
	unsigned char bitNumbers[8] = {0,0,0,0,0,0,0,0};
	unsigned int quotient = number;
	unsigned char remainder = 0;
	unsigned char loopCount = 0;
	if (number == 0)
	{
		return bitNumbers;
	}

	for(loopCount = 0; loopCount < 8; loopCount++)
	{
		remainder = quotient % 10;
		bitNumbers[loopCount] = remainder;
		quotient = quotient / 10;
		if (quotient == 0)
			break;
	}
	return bitNumbers;
}