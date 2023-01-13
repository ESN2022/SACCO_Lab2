#include <system.h>
#include "altera_avalon_pio_regs.h"
int main()
{
	while(1)
	{
		for (int i=0; i<=9;i++)
		{
			IOWR_ALTERA_AVALON_PIO_DATA(PIO_0_BASE,i);
			usleep(500000);
		}	
	}
	return 0;
}