#include <system.h>
#include "altera_avalon_pio_regs.h"
#include "altera_avalon_timer_regs.h"
#include "sys/alt_irq.h"

/*int main()
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
*/


unsigned int i =0;
int cnt;
static void timer_irq()
{

	if ((i&0xF) ==10)
	{
		i =i+6;
	}
	else if ((i&0xF0)>>4 ==10)
	{
		i=i+96;
	}
	IOWR_ALTERA_AVALON_PIO_DATA(PIO_0_BASE,i);		
	i++;
	IOWR_ALTERA_AVALON_TIMER_STATUS(TIMER_0_BASE,0);
}

int main()
{

	alt_irq_register(TIMER_0_IRQ,NULL,timer_irq);
	while(1);
	return 0;
}
