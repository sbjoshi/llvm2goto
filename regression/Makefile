export LLVM_BIN_PATH = /home/rasika/Downloads/llvm_clang/build/bin/clang

compile : c
	export LLVM_BIN_PATH
	# echo $(LLVM_BIN_PATH)
	$(MAKE) -C c
clean:
	$(MAKE) -C c clean