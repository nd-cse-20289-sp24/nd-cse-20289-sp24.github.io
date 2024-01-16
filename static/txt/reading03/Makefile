test:
	@$(MAKE) -sk test-all

test-all:	test-scripts test-filters

test-scripts:
	curl -sLO https://www3.nd.edu/~pbui/teaching/cse.20289.sp24/static/txt/reading03/test_filters.sh
	chmod +x test_filters.sh

test-filters:
	./test_filters.sh
