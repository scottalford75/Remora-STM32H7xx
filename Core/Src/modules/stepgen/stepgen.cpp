#include "stepgen.h"


/***********************************************************************
                MODULE CONFIGURATION AND CREATION FROM JSON     
************************************************************************/

void createStepgen()
{
    const char* comment = module["Comment"];
    printf("%s\n",comment);

    int joint = module["Joint Number"];
    const char* enable = module["Enable Pin"];
    const char* step = module["Step Pin"];
    const char* dir = module["Direction Pin"];

    // create the step generator, register it in the thread
    Module* stepgen = new Stepgen(base_freq, joint, enable, step, dir, STEPBIT);
    baseThread->registerModule(stepgen);
    baseThread->registerModulePost(stepgen);
}


/***********************************************************************
                METHOD DEFINITIONS
************************************************************************/

Stepgen::Stepgen(int32_t threadFreq, int jointNumber, std::string enable, std::string step, std::string direction, int stepBit) :
	jointNumber(jointNumber),
	enable(enable),
	step(step),
	direction(direction),
	stepBit(stepBit)
{
	this->enablePin = new Pin(this->enable, OUTPUT);			// create Pins
	this->stepPin = new Pin(this->step, OUTPUT);
	this->directionPin = new Pin(this->direction, OUTPUT);
    this->rawCount = 0;
	this->DDSaccumulator = 0;
	this->frequencyScale = (float)(1 << this->stepBit) / (float)threadFreq;
	this->mask = 1 << this->jointNumber;
	this->isEnabled = false;
	this->isForward = false;

    this->pin = new Pin("PE_12", OUTPUT);
}


void Stepgen::update()
{
	// Use the standard Module interface to run makePulses()
	this->makePulses();
}

void Stepgen::updatePost()
{
	this->stopPulses();
}

void Stepgen::slowUpdate()
{
	return;
}

void Stepgen::makePulses()
{
	int32_t stepNow = 0;

	this->rxData = getCurrentRxBuffer(&rxPingPongBuffer);
	this->txData = getCurrentTxBuffer(&txPingPongBuffer);

	this->rxData2 = getAltRxBuffer(&rxPingPongBuffer);

	this->isEnabled = ((rxData->jointEnable & this->mask) != 0);

	if (this->isEnabled == true)  												// this Step generator is enables so make the pulses
	{
		this->pin->set(1);

		this->enablePin->set(false);                                			// Enable the driver - CHANGE THIS TO MAKE THE OUTPUT VALUE CONFIGURABLE???

		this->frequencyCommand = rxData->jointFreqCmd[this->jointNumber]; 		// Get the latest frequency command via pointer to the data source
		this->DDSaddValue = this->frequencyCommand * this->frequencyScale;		// Scale the frequency command to get the DDS add value
		stepNow = this->DDSaccumulator;                           				// Save the current DDS accumulator value
		this->DDSaccumulator += this->DDSaddValue;           	  				// Update the DDS accumulator with the new add value
		stepNow ^= this->DDSaccumulator;                          				// Test for changes in the low half of the DDS accumulator
		stepNow &= (1L << this->stepBit);                         				// Check for the step bit

		if (this->DDSaddValue > 0)												// The sign of the DDS add value indicates the desired direction
		{
			this->isForward = true;
		}
		else //if (this->DDSaddValue < 0)
		{
			this->isForward = false;
		}

		if (stepNow)
		{
			this->directionPin->set(this->isForward);             		    // Set direction pin
			this->stepPin->set(true);
            if (this->isForward)
            {
                ++this->rawCount;
            }
            else
            {
                --this->rawCount;
            }
            txData->jointFeedback[this->jointNumber] = this->rawCount;
            this->isStepping = true;
		}
		this->pin->set(0);

	}
	else
	{
		this->enablePin->set(true);
	}

}

void Stepgen::stopPulses()
{
	this->stepPin->set(false);	// Reset step pin
	this->isStepping = false;
}


void Stepgen::setEnabled(bool state)
{
	this->isEnabled = state;
}