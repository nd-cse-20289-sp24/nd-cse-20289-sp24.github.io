test:
	@$(MAKE) -sk test-all

test-all:	test-cut test-wc

test-data:
	@curl -sLO https://www3.nd.edu/~pbui/teaching/cse.20289.sp24/static/txt/homework04/cut.input
	@curl -sLO https://www3.nd.edu/~pbui/teaching/cse.20289.sp24/static/txt/homework04/wc.input

test-scripts:	test-data
	@curl -sLO https://www3.nd.edu/~pbui/teaching/cse.20289.sp24/static/txt/homework04/cut.test
	@curl -sLO https://www3.nd.edu/~pbui/teaching/cse.20289.sp24/static/txt/homework04/wc.test

	@chmod +x ./*.test

test-cut:	test-scripts cut.py
	@echo Testing Cut ...
	@./cut.test -v
	@echo

test-wc: 	test-scripts wc.py
	@echo Testing WC ...
	@./wc.test -v
	@echo

clean:
	@rm -f *.input *.test
