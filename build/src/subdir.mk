################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
CPP_SRCS += \
../src/initialize_goto.cpp \
../src/ll2gb.cpp \
../src/preprocess.cpp \
../src/scope_tree.cpp \
../src/symbol_util.cpp \
../src/translator.cpp \
../src/util.cpp 

OBJS += \
./src/initialize_goto.o \
./src/ll2gb.o \
./src/preprocess.o \
./src/scope_tree.o \
./src/symbol_util.o \
./src/translator.o \
./src/util.o 

CPP_DEPS += \
./src/initialize_goto.d \
./src/ll2gb.d \
./src/preprocess.d \
./src/scope_tree.d \
./src/symbol_util.d \
./src/translator.d \
./src/util.d 


# Each subdirectory must supply rules for building sources it contributes
src/%.o: ../src/%.cpp
	@echo 'Building file: $<'
	@$(CXX) -std=c++0x -I"`llvm-config --includedir`" -I$(CBMC_DIR)/src $(CXX_FLAGS) -Wall -Wextra -c -fmessage-length=0 `llvm-config --cppflags` -Wno-deprecated-declarations -Wno-unused-parameter `llvm-config --cxxflags` -fexceptions -pthread -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -o "$@" "$<"
	@echo 'Finished building: $<'


