################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
CPP_SRCS += \
../src/llvm2goto-2.0.cpp \
../src/llvm2goto_translator.cpp 

OBJS += \
./src/llvm2goto-2.0.o \
./src/llvm2goto_translator.o 

CPP_DEPS += \
./src/llvm2goto-2.0.d \
./src/llvm2goto_translator.d 


# Each subdirectory must supply rules for building sources it contributes
src/%.o: ../src/%.cpp
	@echo 'Building file: $<'
	@echo 'Invoking: GCC C++ Compiler'
	g++ -std=c++0x -I"/home/akash/Documents/CBMC/cbmc/src" -I"`llvm-config --includedir`" -I"/home/akash/Documents/LLVM/llvm-project/llvm/include" -O0 -g3 -Wall -Wextra -c -fmessage-length=0 `llvm-config --cppflags` -Wno-deprecated-declarations -Wno-unused-parameter `llvm-config --cxxflags` -fexceptions -pthread -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

