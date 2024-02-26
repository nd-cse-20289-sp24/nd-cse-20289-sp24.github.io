test:
	@$(MAKE) -sk test-all

test-all:	test-odds

test-scripts:	
	@curl -sLO https://www3.nd.edu/~pbui/teaching/cse.20289.sp24/static/txt/reading07/odds.test
	@chmod +x ./*.test

test-odds:	test-scripts odds.py
	@echo Testing Odds ...
	@./odds.test -v
	@echo
clean:
	@rm -f *.test
