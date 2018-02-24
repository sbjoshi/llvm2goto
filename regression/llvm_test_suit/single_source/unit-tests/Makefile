SRC_DIR := .
OBJ_DIR := .
SRC_FILES := $(wildcard $(SRC_DIR)/*.c)
OBJ_FILES := $(patsubst $(SRC_DIR)/%.c,$(OBJ_DIR)/%.ll,$(SRC_FILES))
LLFLAGS = -c -S -g -emit-llvm
SUBDIRS := $(wildcard */.)

# all: $(SUBDIRS)
# 	# echo $(DIRS)

# $(SUBDIRS):
# 	$(MAKE) -C $@

compile: $(OBJ_FILES)
	@echo "Compiled all c files using clang."
	echo $(SUBDIRS)

$(OBJ_DIR)/%.ll: $(SRC_DIR)/%.c
	$(LLVM_BIN_PATH) $(LLFLAGS) -o $@ $<

clean:
	rm *.ll