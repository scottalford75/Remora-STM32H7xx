################################################################################
# Automatically-generated file. Do not edit!
# Toolchain: GNU Tools for STM32 (12.3.rel1)
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
CPP_SRCS += \
../Core/Src/remora/drivers/TMCStepper/CHOPCONF.cpp \
../Core/Src/remora/drivers/TMCStepper/COOLCONF.cpp \
../Core/Src/remora/drivers/TMCStepper/DRV_STATUS.cpp \
../Core/Src/remora/drivers/TMCStepper/GCONF.cpp \
../Core/Src/remora/drivers/TMCStepper/IHOLD_IRUN.cpp \
../Core/Src/remora/drivers/TMCStepper/PWMCONF.cpp \
../Core/Src/remora/drivers/TMCStepper/TMC2130Stepper.cpp \
../Core/Src/remora/drivers/TMCStepper/TMC2160Stepper.cpp \
../Core/Src/remora/drivers/TMCStepper/TMC2208Stepper.cpp \
../Core/Src/remora/drivers/TMCStepper/TMC2209Stepper.cpp \
../Core/Src/remora/drivers/TMCStepper/TMC5130Stepper.cpp \
../Core/Src/remora/drivers/TMCStepper/TMC5160Stepper.cpp \
../Core/Src/remora/drivers/TMCStepper/TMCStepper.cpp 

OBJS += \
./Core/Src/remora/drivers/TMCStepper/CHOPCONF.o \
./Core/Src/remora/drivers/TMCStepper/COOLCONF.o \
./Core/Src/remora/drivers/TMCStepper/DRV_STATUS.o \
./Core/Src/remora/drivers/TMCStepper/GCONF.o \
./Core/Src/remora/drivers/TMCStepper/IHOLD_IRUN.o \
./Core/Src/remora/drivers/TMCStepper/PWMCONF.o \
./Core/Src/remora/drivers/TMCStepper/TMC2130Stepper.o \
./Core/Src/remora/drivers/TMCStepper/TMC2160Stepper.o \
./Core/Src/remora/drivers/TMCStepper/TMC2208Stepper.o \
./Core/Src/remora/drivers/TMCStepper/TMC2209Stepper.o \
./Core/Src/remora/drivers/TMCStepper/TMC5130Stepper.o \
./Core/Src/remora/drivers/TMCStepper/TMC5160Stepper.o \
./Core/Src/remora/drivers/TMCStepper/TMCStepper.o 

CPP_DEPS += \
./Core/Src/remora/drivers/TMCStepper/CHOPCONF.d \
./Core/Src/remora/drivers/TMCStepper/COOLCONF.d \
./Core/Src/remora/drivers/TMCStepper/DRV_STATUS.d \
./Core/Src/remora/drivers/TMCStepper/GCONF.d \
./Core/Src/remora/drivers/TMCStepper/IHOLD_IRUN.d \
./Core/Src/remora/drivers/TMCStepper/PWMCONF.d \
./Core/Src/remora/drivers/TMCStepper/TMC2130Stepper.d \
./Core/Src/remora/drivers/TMCStepper/TMC2160Stepper.d \
./Core/Src/remora/drivers/TMCStepper/TMC2208Stepper.d \
./Core/Src/remora/drivers/TMCStepper/TMC2209Stepper.d \
./Core/Src/remora/drivers/TMCStepper/TMC5130Stepper.d \
./Core/Src/remora/drivers/TMCStepper/TMC5160Stepper.d \
./Core/Src/remora/drivers/TMCStepper/TMCStepper.d 


# Each subdirectory must supply rules for building sources it contributes
Core/Src/remora/drivers/TMCStepper/%.o Core/Src/remora/drivers/TMCStepper/%.su Core/Src/remora/drivers/TMCStepper/%.cyclo: ../Core/Src/remora/drivers/TMCStepper/%.cpp Core/Src/remora/drivers/TMCStepper/subdir.mk
	arm-none-eabi-g++ "$<" -mcpu=cortex-m7 -std=gnu++17 -g3 -DDEBUG -DUSE_HAL_DRIVER -DSTM32H743xx -c -I../FATFS/Target -I"F:/Local Repositories/Remora-STM32CubeIDE/Remora-STM32H7xx/Core/Src/lib/ArduinoJson7" -I../FATFS/App -I../Core/Inc -I../Drivers/STM32H7xx_HAL_Driver/Inc -I../Drivers/STM32H7xx_HAL_Driver/Inc/Legacy -I../Middlewares/Third_Party/FatFs/src -I../Drivers/CMSIS/Device/ST/STM32H7xx/Include -I../Drivers/CMSIS/Include -O0 -ffunction-sections -fdata-sections -fno-exceptions -fno-rtti -fno-use-cxa-atexit -Wall -fstack-usage -fcyclomatic-complexity -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv5-d16 -mfloat-abi=hard -mthumb -o "$@"

clean: clean-Core-2f-Src-2f-remora-2f-drivers-2f-TMCStepper

clean-Core-2f-Src-2f-remora-2f-drivers-2f-TMCStepper:
	-$(RM) ./Core/Src/remora/drivers/TMCStepper/CHOPCONF.cyclo ./Core/Src/remora/drivers/TMCStepper/CHOPCONF.d ./Core/Src/remora/drivers/TMCStepper/CHOPCONF.o ./Core/Src/remora/drivers/TMCStepper/CHOPCONF.su ./Core/Src/remora/drivers/TMCStepper/COOLCONF.cyclo ./Core/Src/remora/drivers/TMCStepper/COOLCONF.d ./Core/Src/remora/drivers/TMCStepper/COOLCONF.o ./Core/Src/remora/drivers/TMCStepper/COOLCONF.su ./Core/Src/remora/drivers/TMCStepper/DRV_STATUS.cyclo ./Core/Src/remora/drivers/TMCStepper/DRV_STATUS.d ./Core/Src/remora/drivers/TMCStepper/DRV_STATUS.o ./Core/Src/remora/drivers/TMCStepper/DRV_STATUS.su ./Core/Src/remora/drivers/TMCStepper/GCONF.cyclo ./Core/Src/remora/drivers/TMCStepper/GCONF.d ./Core/Src/remora/drivers/TMCStepper/GCONF.o ./Core/Src/remora/drivers/TMCStepper/GCONF.su ./Core/Src/remora/drivers/TMCStepper/IHOLD_IRUN.cyclo ./Core/Src/remora/drivers/TMCStepper/IHOLD_IRUN.d ./Core/Src/remora/drivers/TMCStepper/IHOLD_IRUN.o ./Core/Src/remora/drivers/TMCStepper/IHOLD_IRUN.su ./Core/Src/remora/drivers/TMCStepper/PWMCONF.cyclo ./Core/Src/remora/drivers/TMCStepper/PWMCONF.d ./Core/Src/remora/drivers/TMCStepper/PWMCONF.o ./Core/Src/remora/drivers/TMCStepper/PWMCONF.su ./Core/Src/remora/drivers/TMCStepper/TMC2130Stepper.cyclo ./Core/Src/remora/drivers/TMCStepper/TMC2130Stepper.d ./Core/Src/remora/drivers/TMCStepper/TMC2130Stepper.o ./Core/Src/remora/drivers/TMCStepper/TMC2130Stepper.su ./Core/Src/remora/drivers/TMCStepper/TMC2160Stepper.cyclo ./Core/Src/remora/drivers/TMCStepper/TMC2160Stepper.d ./Core/Src/remora/drivers/TMCStepper/TMC2160Stepper.o ./Core/Src/remora/drivers/TMCStepper/TMC2160Stepper.su ./Core/Src/remora/drivers/TMCStepper/TMC2208Stepper.cyclo ./Core/Src/remora/drivers/TMCStepper/TMC2208Stepper.d ./Core/Src/remora/drivers/TMCStepper/TMC2208Stepper.o ./Core/Src/remora/drivers/TMCStepper/TMC2208Stepper.su ./Core/Src/remora/drivers/TMCStepper/TMC2209Stepper.cyclo ./Core/Src/remora/drivers/TMCStepper/TMC2209Stepper.d ./Core/Src/remora/drivers/TMCStepper/TMC2209Stepper.o ./Core/Src/remora/drivers/TMCStepper/TMC2209Stepper.su ./Core/Src/remora/drivers/TMCStepper/TMC5130Stepper.cyclo ./Core/Src/remora/drivers/TMCStepper/TMC5130Stepper.d ./Core/Src/remora/drivers/TMCStepper/TMC5130Stepper.o ./Core/Src/remora/drivers/TMCStepper/TMC5130Stepper.su ./Core/Src/remora/drivers/TMCStepper/TMC5160Stepper.cyclo ./Core/Src/remora/drivers/TMCStepper/TMC5160Stepper.d ./Core/Src/remora/drivers/TMCStepper/TMC5160Stepper.o ./Core/Src/remora/drivers/TMCStepper/TMC5160Stepper.su ./Core/Src/remora/drivers/TMCStepper/TMCStepper.cyclo ./Core/Src/remora/drivers/TMCStepper/TMCStepper.d ./Core/Src/remora/drivers/TMCStepper/TMCStepper.o ./Core/Src/remora/drivers/TMCStepper/TMCStepper.su

.PHONY: clean-Core-2f-Src-2f-remora-2f-drivers-2f-TMCStepper

