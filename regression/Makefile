export LLVM_BIN_PATH = /home/ubuntu/clang-5.0.1.src/build/bin/clang

compile : c
	export LLVM_BIN_PATH
	# echo $(LLVM_BIN_PATH)
	$(MAKE) -C c
clean:
	$(MAKE) -C c clean