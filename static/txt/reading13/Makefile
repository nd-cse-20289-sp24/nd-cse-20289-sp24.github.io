CC=             gcc
CFLAGS=         -Wall -g -std=gnu99
TARGETS=        ncat

all:            $(TARGETS)

# TODO: Add rule for ncat

test:
	        @$(MAKE) -sk test-all

test-all:	test-ncat

test-ncat:	ncat
	curl -sLO https://www3.nd.edu/~pbui/teaching/cse.20289.sp24/static/txt/reading13/ncat.test.sh
	chmod +x ncat.test.sh
	./ncat.test.sh

clean:
	rm -f $(TARGETS)

.SUFFIXES:
