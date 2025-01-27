#include "extern.h"


void createThreads(void)
{
	baseThread = new pruThread(TIM3, TIM3_IRQn, base_freq, baseCount);
	NVIC_SetPriority(TIM3_IRQn, BASE_THREAD_IRQ_PRIORITY);

	servoThread = new pruThread(TIM2, TIM2_IRQn, servo_freq, servoCount);
	NVIC_SetPriority(TIM2_IRQn, SERVO_THREAD_IRQ_PRIORITY);

	commsThread = new pruThread(TIM4, TIM4_IRQn, PRU_COMMSFREQ, commsCount);
	NVIC_SetPriority(TIM4_IRQn, COMMS_THREAD_IRQ_PRIORITY);
}
