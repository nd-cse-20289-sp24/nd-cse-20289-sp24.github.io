CC=             gcc
CFLAGS=         -Wall -g -std=gnu99
TARGETS=        str_rev

all:            $(TARGETS)

#-------------------------------------------------------------------------------
# TODO: Add rule for str_rev
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
# DO NOT MODIFY BELOW
#-------------------------------------------------------------------------------

test:
	        @$(MAKE) -sk test-all

test-all:	test-str

test-str:	str_rev
	curl -sLO https://www3.nd.edu/~pbui/teaching/cse.20289.sp24/static/txt/reading10/str_rev.test.sh
	chmod +x str_rev.test.sh
	./str_rev.test.sh

clean:
	rm -f $(TARGETS)

.SUFFIXES:
