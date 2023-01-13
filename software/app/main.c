#include <system.h>
#include "altera_avalon_pio_regs.h"
int main()
{

	while(1)
	{
		for (int i =0; i<=9;i++)
		{
			for (int j =0; j<=9;j++)
			{
				for (int k=0; k<=9;k++)
				{
					IOWR_ALTERA_AVALON_PIO_DATA(PIO_0_BASE,i<<8 | j<<4 | k);
				usleep(100000);				
				}
			}

		}	

	}
	return 0;
}