test:
	@$(MAKE) -sk test-all

test-all:	test-namez test-searx

test-data:
	@curl -sLO https://www3.nd.edu/~pbui/teaching/cse.20289.sp24/static/txt/homework05/namez.input.gz
	@curl -sLO https://www3.nd.edu/~pbui/teaching/cse.20289.sp24/static/txt/homework05/namez.input.test.gz
	@echo "*.gz" > .gitignore
	@echo "*.test" >> .gitignore

test-scripts:	test-data
	@curl -sLO https://www3.nd.edu/~pbui/teaching/cse.20289.sp24/static/txt/homework05/namez.test
	@curl -sLO https://www3.nd.edu/~pbui/teaching/cse.20289.sp24/static/txt/homework05/searx.test
	@chmod +x ./*.test

test-namez:	test-scripts namez.py
	@echo Testing NameZ ...
	@./namez.test -v
	@echo

test-searx:	test-scripts searx.py
	@echo Testing SearX ...
	@./searx.test -v
	@echo

clean:
	@rm -f *.test *.gz
