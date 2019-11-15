default: test

test:
	@ ./test.pl -c cbmc

tests.log: ./test.pl
	@ ./test.pl -c cbmc

show:
	@for dir in *; do \
		if [ -d "$$dir" ]; then \
			vim -o "$$dir/*.c.goto" "$$dir/*.out"; \
		fi; \
	done;
