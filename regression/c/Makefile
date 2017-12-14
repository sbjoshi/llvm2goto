SUBDIR_ROOTS := .
DIRS := . $(shell find $(SUBDIR_ROOTS) -type d)
GARBAGE_PATTERNS := *.ll *.goto
GARBAGE := $(foreach DIR,$(DIRS),$(addprefix $(DIR)/,$(GARBAGE_PATTERNS)))
SUBDIRS := $(wildcard */.)
export LLVM_BIN_PATH
# SUBDIRS := $(wildcard */.)
# export LLVM_BIN_PATH

# all: mew
	
# mew:
# 	$(MAKE) -C arithmetic_operations

# clean:
# 	$(MAKE) -C arithmetic_operations clean

all: $(SUBDIRS)
	# echo $(DIRS)

$(SUBDIRS):
	$(MAKE) -C $@

clean:
	rm -rf $(GARBAGE)

.PHONY: all $(SUBDIRS)
