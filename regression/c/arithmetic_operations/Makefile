SUBDIR_ROOTS := .
DIRS := . $(shell find $(SUBDIR_ROOTS) -type d)
GARBAGE_PATTERNS := *.ll *.goto
GARBAGE := $(foreach DIR,$(DIRS),$(addprefix $(DIR)/,$(GARBAGE_PATTERNS)))
SUBDIRS := $(wildcard */.)
export LLVM_BIN_PATH
all: $(SUBDIRS)
	# echo $(DIRS)

$(SUBDIRS):
	$(MAKE) -C $@

clean:
	rm -rf $(GARBAGE)

.PHONY: all $(SUBDIRS)
