
#include "tmc.h"
#include <cstdint>

#define TOFF_VALUE  4 // [1... 15]

std::shared_ptr<Module> TMC2209::create(const JsonObject& config, Remora* instance) {
    printf("Creating TMC2209 module\n");

    const char* comment = config["Comment"];
    printf("%s\n",comment);

    const char* RxPin = config["RX pin"];
    float RSense = config["RSense"];
    uint8_t address = config["Address"];
    uint16_t current = config["Current"];
    uint16_t microsteps = config["Microsteps"];
    const char* stealth = config["Stealth chop"];
    uint16_t stall = config["Stall sensitivity"];

    bool stealthchop = (strcmp(stealth, "on") == 0);

    // SW Serial pin, RSense, mA, microsteps, stealh
    // TMC2208(std::string, float, uint8_t, uint16_t, uint16_t, bool);
    auto tmc = std::make_shared<TMC2209>(RxPin, RSense, address, current, microsteps, stealthchop, stall);

    printf("\nStarting the Serial thread\n");
    instance->getSerialThread()->startThread();
    instance->getSerialThread()->registerModule(tmc);

    tmc->configure();

    printf("\nStopping the Serial thread\n");
    instance->getSerialThread()->stopThread();
    instance->getSerialThread()->unregisterModule(tmc);
}


/***********************************************************************
                METHOD DEFINITIONS
************************************************************************/

    // SW Serial pin, RSense, addr, mA, microsteps, stealh, hybrid, stall
    // TMC2209(std::string, float, uint8_t, uint16_t, uint16_t, bool, uint16_t);
TMC2209::TMC2209(std::string rxtxPin, float Rsense, uint8_t addr, uint16_t mA, uint16_t microsteps, bool stealth, uint16_t stall) :
    rxtxPin(rxtxPin),
    mA(mA),
    microsteps(microsteps),
    stealth(stealth),
    addr(addr),
    stall(stall)
{
    this->Rsense = Rsense;
    this->driver = new TMC2209Stepper(this->rxtxPin, this->rxtxPin, this->Rsense, this->addr);
}

TMC2209::~TMC2209()
{
    delete this->driver;
}

void TMC2209::configure()
{
    uint16_t result;

    driver->begin();
    
    printf("Testing connection to TMC driver...");
    result = driver->test_connection();
    if (result) {
        printf("failed!\n");
        printf("Likely cause: ");
        switch(result) {
            case 1: printf("loose connection\n"); break;
            case 2: printf("no power\n"); break;
        }
        printf("  Fix the problem and reset board.\n");
        //abort();
    }
    else   
    {
        printf("OK\n");
    }


    // Sets the slow decay time (off time) [1... 15]. This setting also limits
    // the maximum chopper frequency. For operation with StealthChop,
    // this parameter is not used, but it is required to enable the motor.
    // In case of operation with StealthChop only, any setting is OK.
    driver->toff(TOFF_VALUE);

    // Comparator blank time. This time needs to safely cover the switching
    // event and the duration of the ringing on the sense resistor. For most
    // applications, a setting of 16 or 24 is good. For highly capacitive
    // loads, a setting of 32 or 40 will be required.
    driver->blank_time(24);

    driver->rms_current(this->mA);
    driver->microsteps(this->microsteps);

    // Lower threshold velocity for switching on smart energy CoolStep and StallGuard to DIAG output
    driver->TCOOLTHRS(0xFFFFF); // 20bit max
    
    // CoolStep lower threshold [0... 15].
    // If SG_RESULT goes below this threshold, CoolStep increases the current to both coils.
    // 0: disable CoolStep
    driver->semin(5);

    // CoolStep upper threshold [0... 15].
    // If SG is sampled equal to or above this threshold enough times,
    // CoolStep decreases the current to both coils.
    driver->semax(2);

    // Sets the number of StallGuard2 readings above the upper threshold necessary
    // for each current decrement of the motor current.
    driver->sedn(0b01);

    // Toggle spreadCycle on TMC2208/2209/2224: default false, true: much faster!!!!
    driver->en_spreadCycle(!this->stealth);            
    
    // Needed for StealthChop
    driver->pwm_autoscale(true);             

    // StallGuard is only possible if StealthChop is enabled
    if (this->stealth && this->stall)
    {
        // StallGuard4 threshold [0... 255] level for stall detection. It compensates for
        // motor specific characteristics and controls sensitivity. A higher value gives a higher
        // sensitivity. A higher value makes StallGuard4 more sensitive and requires less torque to
        // indicate a stall. The double of this value is compared to SG_RESULT.
        // The stall output becomes active if SG_RESULT fall below this value.
        driver->SGTHRS(this->stall);             
    }

    driver->iholddelay(10);

    driver->TPOWERDOWN(128);    // ~2s until driver lowers to hold current
    
}

void TMC2209::update()
{
    this->driver->SWSerial->tickerHandler();
}

