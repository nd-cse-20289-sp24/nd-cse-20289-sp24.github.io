test:
	@$(MAKE) -sk test-all

test-all:	test-scripts test-exists

test-scripts:
	curl -sLO https://www3.nd.edu/~pbui/teaching/cse.20289.sp24/static/txt/reading05/test_exists.sh
	chmod +x test_*.sh

test-exists:
	./test_exists.sh
