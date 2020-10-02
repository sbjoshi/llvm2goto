default: test

test:
	@ ./test.pl -c /home/<your_path_here>/cbmc/src/cbmc/cbmc

tests.log: ./test.pl
	@ ./test.pl -c /home/<your_path_here>/cbmc/src/cbmc/cbmc

show:
	@for dir in *; do \
		if [ -d "$$dir" ]; then \
			vim -o "$$dir/*.c.goto" "$$dir/*.out"; \
		fi; \
	done;
