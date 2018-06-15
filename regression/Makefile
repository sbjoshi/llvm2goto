default: test

test:
	@ ./test.pl -c /home/rasika/Downloads/cbmc-cbmc-5.8/src/cbmc/cbmc

tests.log: ./test.pl
	@ ./test.pl -c /home/rasika/Downloads/cbmc-cbmc-5.8/src/cbmc/cbmc

show:
	@for dir in *; do \
		if [ -d "$$dir" ]; then \
			vim -o "$$dir/*.c.goto" "$$dir/*.out"; \
		fi; \
	done;
