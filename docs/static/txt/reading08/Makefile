test:
	@$(MAKE) -sk test-all

test-all:	test-scripts test-translations

test-scripts:
	curl -sLO https://www3.nd.edu/~pbui/teaching/cse.20289.sp24/static/txt/reading08/test_translations.sh
	chmod +x test_translations.sh

test-translations:
	./test_translations.sh

