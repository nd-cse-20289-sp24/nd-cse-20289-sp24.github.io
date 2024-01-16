test:
	@$(MAKE) -sk test-all

test-all:	test-scripts test-weather test-zipcode

test-scripts:
	curl -sLO https://www3.nd.edu/~pbui/teaching/cse.20289.sp24/static/txt/homework03/test_weather.sh
	curl -sLO https://www3.nd.edu/~pbui/teaching/cse.20289.sp24/static/txt/homework03/test_zipcode.sh
	chmod +x test_*.sh

test-weather:
	./test_weather.sh

test-zipcode:
	./test_zipcode.sh
