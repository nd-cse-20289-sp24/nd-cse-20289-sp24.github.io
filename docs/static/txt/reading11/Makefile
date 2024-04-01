CC=             gcc
CFLAGS=         -Wall -g -std=gnu99
TARGETS=        walk

all:            $(TARGETS)

# TODO: Add rule for walk

test:
	        @$(MAKE) -sk test-all

test-all:	test-walk

test-walk:	walk
	curl -sLO https://www3.nd.edu/~pbui/teaching/cse.20289.sp24/static/txt/reading11/test_walk.sh
	chmod +x test_walk.sh
	./test_walk.sh

clean:
	rm -f $(TARGETS)

.SUFFIXES:
