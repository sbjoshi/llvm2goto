################################################################################
# Automatically-generated file. Do not edit!
################################################################################

-include ../makefile.init
-include config.inc

RM := rm -rf

# All of the sources participating in the build are defined here
-include sources.mk
-include src/subdir.mk
-include subdir.mk
-include objects.mk

ifneq ($(MAKECMDGOALS),clean)
ifneq ($(strip $(CC_DEPS)),)
-include $(CC_DEPS)
endif
ifneq ($(strip $(C++_DEPS)),)
-include $(C++_DEPS)
endif
ifneq ($(strip $(C_UPPER_DEPS)),)
-include $(C_UPPER_DEPS)
endif
ifneq ($(strip $(CXX_DEPS)),)
-include $(CXX_DEPS)
endif
ifneq ($(strip $(CPP_DEPS)),)
-include $(CPP_DEPS)
endif
ifneq ($(strip $(C_DEPS)),)
-include $(C_DEPS)
endif
endif

-include ../makefile.defs

# Add inputs and outputs from these tool invocations to the build variables

# All Target
all: ll2gb

# Tool invocations
ll2gb: $(OBJS) $(USER_OBJS)
	@echo 'Building target: $@'
	@$(CXX) -L"`$(LLVM_CONFIG) --libdir`" -L$(CBMC_DIR) -pthread -o "ll2gb" $(OBJS) $(USER_OBJS) $(LIBS) `$(LLVM_CONFIG) --libs --system-libs irreader passes`
	@echo 'Finished building target: $@'
	@echo ' '

# Other Targets
clean:
	-$(RM) $(CC_DEPS)$(C++_DEPS)$(EXECUTABLES)$(C_UPPER_DEPS)$(CXX_DEPS)$(OBJS)$(CPP_DEPS)$(C_DEPS) ll2gb
	-@echo ' '

.PHONY: all clean dependents

-include ../makefile.targets
