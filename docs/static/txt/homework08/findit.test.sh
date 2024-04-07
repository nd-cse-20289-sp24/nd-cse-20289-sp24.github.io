#!/bin/bash

WORKSPACE=/tmp/findit.$(id -u)
FAILURES=0
POINTS=3

error() {
    echo "$@"
    [ -r $WORKSPACE/test ] && (echo; cat $WORKSPACE/test; echo)
    FAILURES=$((FAILURES + 1))
}

cleanup() {
    STATUS=${1:-$FAILURES}
    rm -fr $WORKSPACE
    exit $STATUS
}

export LD_LIBRARY_PATH=$LD_LIBRRARY_PATH:.

mkdir $WORKSPACE

trap "cleanup" EXIT
trap "cleanup 1" INT TERM

echo "Testing findit utility..."

printf " %-60s ... " "findit"
./findit &> $WORKSPACE/test
if [ $? -eq 0 ]; then
    error "Failure"
else
    echo "Success"
fi

printf " %-60s ... " "findit (valgrind)"
valgrind --leak-check=full ./findit &> $WORKSPACE/test
if [ $? -eq 0 ] || [ $(awk '/ERROR SUMMARY:/ {print $4}' $WORKSPACE/test) -ne 0 ]; then
    error "Failure"
else
    echo "Success"
fi

FINDIT_PATH="/etc"

FINDIT_ARGS=""

printf " %-60s ... " "findit $FINDIT_PATH $FINDIT_ARGS"
diff -y <(./findit $FINDIT_PATH $FINDIT_ARGS | sort)  <(find $FINDIT_PATH $FINDIT_ARGS 2> /dev/null | sort) &> $WORKSPACE/test
if [ $? -ne 0 ]; then
    error "Failure"
else
    echo "Success"
fi

printf " %-60s ... " "findit $FINDIT_PATH $FINDIT_ARGS (valgrind)"
valgrind --leak-check=full ./findit $FINDIT_PATH $FINDIT_ARGS &> $WORKSPACE/test
if [ $? -ne 0 ] || [ $(awk '/ERROR SUMMARY:/ {print $4}' $WORKSPACE/test) -ne 0 ]; then
    error "Failure"
else
    echo "Success"
fi

FINDIT_ARGS="-type f"

printf " %-60s ... " "findit $FINDIT_PATH $FINDIT_ARGS"
diff -y <(./findit $FINDIT_PATH $FINDIT_ARGS | sort)  <(find $FINDIT_PATH $FINDIT_ARGS 2> /dev/null | sort) &> $WORKSPACE/test
if [ $? -ne 0 ]; then
    error "Failure"
else
    echo "Success"
fi

printf " %-60s ... " "findit $FINDIT_PATH $FINDIT_ARGS (valgrind)"
valgrind --leak-check=full ./findit $FINDIT_PATH $FINDIT_ARGS &> $WORKSPACE/test
if [ $? -ne 0 ] || [ $(awk '/ERROR SUMMARY:/ {print $4}' $WORKSPACE/test) -ne 0 ]; then
    error "Failure"
else
    echo "Success"
fi

FINDIT_ARGS="-type d"

printf " %-60s ... " "findit $FINDIT_PATH $FINDIT_ARGS"
diff -y <(./findit $FINDIT_PATH $FINDIT_ARGS | sort)  <(find $FINDIT_PATH $FINDIT_ARGS 2> /dev/null | sort) &> $WORKSPACE/test
if [ $? -ne 0 ]; then
    error "Failure"
else
    echo "Success"
fi

printf " %-60s ... " "findit $FINDIT_PATH $FINDIT_ARGS (valgrind)"
valgrind --leak-check=full ./findit $FINDIT_PATH $FINDIT_ARGS &> $WORKSPACE/test
if [ $? -ne 0 ] || [ $(awk '/ERROR SUMMARY:/ {print $4}' $WORKSPACE/test) -ne 0 ]; then
    error "Failure"
else
    echo "Success"
fi

FINDIT_ARGS="-name '*.conf'"

printf " %-60s ... " "findit $FINDIT_PATH $FINDIT_ARGS"
diff -y <(./findit $FINDIT_PATH $FINDIT_ARGS | sort)  <(find $FINDIT_PATH $FINDIT_ARGS 2> /dev/null | sort) &> $WORKSPACE/test
if [ $? -ne 0 ]; then
    error "Failure"
else
    echo "Success"
fi

printf " %-60s ... " "findit $FINDIT_PATH $FINDIT_ARGS (valgrind)"
valgrind --leak-check=full ./findit $FINDIT_PATH $FINDIT_ARGS &> $WORKSPACE/test
if [ $? -ne 0 ] || [ $(awk '/ERROR SUMMARY:/ {print $4}' $WORKSPACE/test) -ne 0 ]; then
    error "Failure"
else
    echo "Success"
fi

FINDIT_ARGS="-readable"

printf " %-60s ... " "findit $FINDIT_PATH $FINDIT_ARGS"
diff -y <(./findit $FINDIT_PATH $FINDIT_ARGS | sort)  <(find $FINDIT_PATH $FINDIT_ARGS 2> /dev/null | sort) &> $WORKSPACE/test
if [ $? -ne 0 ]; then
    error "Failure"
else
    echo "Success"
fi

printf " %-60s ... " "findit $FINDIT_PATH $FINDIT_ARGS (valgrind)"
valgrind --leak-check=full ./findit $FINDIT_PATH $FINDIT_ARGS &> $WORKSPACE/test
if [ $? -ne 0 ] || [ $(awk '/ERROR SUMMARY:/ {print $4}' $WORKSPACE/test) -ne 0 ]; then
    error "Failure"
else
    echo "Success"
fi

FINDIT_ARGS="-writable"

printf " %-60s ... " "findit $FINDIT_PATH $FINDIT_ARGS"
diff -y <(./findit $FINDIT_PATH $FINDIT_ARGS | sort)  <(find $FINDIT_PATH $FINDIT_ARGS 2> /dev/null | sort) &> $WORKSPACE/test
if [ $? -ne 0 ]; then
    error "Failure"
else
    echo "Success"
fi

printf " %-60s ... " "findit $FINDIT_PATH $FINDIT_ARGS (valgrind)"
valgrind --leak-check=full ./findit $FINDIT_PATH $FINDIT_ARGS &> $WORKSPACE/test
if [ $? -ne 0 ] || [ $(awk '/ERROR SUMMARY:/ {print $4}' $WORKSPACE/test) -ne 0 ]; then
    error "Failure"
else
    echo "Success"
fi

FINDIT_ARGS="-executable"

printf " %-60s ... " "findit $FINDIT_PATH $FINDIT_ARGS"
diff -y <(./findit $FINDIT_PATH $FINDIT_ARGS | sort)  <(find $FINDIT_PATH $FINDIT_ARGS 2> /dev/null | sort) &> $WORKSPACE/test
if [ $? -ne 0 ]; then
    error "Failure"
else
    echo "Success"
fi

printf " %-60s ... " "findit $FINDIT_PATH $FINDIT_ARGS (valgrind)"
valgrind --leak-check=full ./findit $FINDIT_PATH $FINDIT_ARGS &> $WORKSPACE/test
if [ $? -ne 0 ] || [ $(awk '/ERROR SUMMARY:/ {print $4}' $WORKSPACE/test) -ne 0 ]; then
    error "Failure"
else
    echo "Success"
fi

FINDIT_ARGS="-type d -name '*.d'"

printf " %-60s ... " "findit $FINDIT_PATH $FINDIT_ARGS"
diff -y <(./findit $FINDIT_PATH $FINDIT_ARGS | sort)  <(find $FINDIT_PATH $FINDIT_ARGS 2> /dev/null | sort) &> $WORKSPACE/test
if [ $? -ne 0 ]; then
    error "Failure"
else
    echo "Success"
fi

printf " %-60s ... " "findit $FINDIT_PATH $FINDIT_ARGS (valgrind)"
valgrind --leak-check=full ./findit $FINDIT_PATH $FINDIT_ARGS &> $WORKSPACE/test
if [ $? -ne 0 ] || [ $(awk '/ERROR SUMMARY:/ {print $4}' $WORKSPACE/test) -ne 0 ]; then
    error "Failure"
else
    echo "Success"
fi

FINDIT_ARGS="-type d -name '*.d' -executable"

printf " %-60s ... " "findit $FINDIT_PATH $FINDIT_ARGS"
diff -y <(./findit $FINDIT_PATH $FINDIT_ARGS | sort)  <(find $FINDIT_PATH $FINDIT_ARGS 2> /dev/null | sort) &> $WORKSPACE/test
if [ $? -ne 0 ]; then
    error "Failure"
else
    echo "Success"
fi

printf " %-60s ... " "findit $FINDIT_PATH $FINDIT_ARGS (valgrind)"
valgrind --leak-check=full ./findit $FINDIT_PATH $FINDIT_ARGS &> $WORKSPACE/test
if [ $? -ne 0 ] || [ $(awk '/ERROR SUMMARY:/ {print $4}' $WORKSPACE/test) -ne 0 ]; then
    error "Failure"
else
    echo "Success"
fi

FINDIT_PATH="."

FINDIT_ARGS="-name '*.c'"

printf " %-60s ... " "findit $FINDIT_PATH $FINDIT_ARGS"
diff -y <(./findit $FINDIT_PATH $FINDIT_ARGS | sort)  <(find $FINDIT_PATH $FINDIT_ARGS 2> /dev/null | sort) &> $WORKSPACE/test
if [ $? -ne 0 ]; then
    error "Failure"
else
    echo "Success"
fi

printf " %-60s ... " "findit $FINDIT_PATH $FINDIT_ARGS (valgrind)"
valgrind --leak-check=full ./findit $FINDIT_PATH $FINDIT_ARGS &> $WORKSPACE/test
if [ $? -ne 0 ] || [ $(awk '/ERROR SUMMARY:/ {print $4}' $WORKSPACE/test) -ne 0 ]; then
    error "Failure"
else
    echo "Success"
fi

FINDIT_ARGS="-writable"

printf " %-60s ... " "findit $FINDIT_PATH $FINDIT_ARGS"
diff -y <(./findit $FINDIT_PATH $FINDIT_ARGS | sort)  <(find $FINDIT_PATH $FINDIT_ARGS 2> /dev/null | sort) &> $WORKSPACE/test
if [ $? -ne 0 ]; then
    error "Failure"
else
    echo "Success"
fi

printf " %-60s ... " "findit $FINDIT_PATH $FINDIT_ARGS (valgrind)"
valgrind --leak-check=full ./findit $FINDIT_PATH $FINDIT_ARGS &> $WORKSPACE/test
if [ $? -ne 0 ] || [ $(awk '/ERROR SUMMARY:/ {print $4}' $WORKSPACE/test) -ne 0 ]; then
    error "Failure"
else
    echo "Success"
fi

FINDIT_ARGS="-type f -name '*.unit' -executable"

printf " %-60s ... " "findit $FINDIT_PATH $FINDIT_ARGS"
diff -y <(./findit $FINDIT_PATH $FINDIT_ARGS | sort)  <(find $FINDIT_PATH $FINDIT_ARGS 2> /dev/null | sort) &> $WORKSPACE/test
if [ $? -ne 0 ]; then
    error "Failure"
else
    echo "Success"
fi

printf " %-60s ... " "findit $FINDIT_PATH $FINDIT_ARGS (valgrind)"
valgrind --leak-check=full ./findit $FINDIT_PATH $FINDIT_ARGS &> $WORKSPACE/test
if [ $? -ne 0 ] || [ $(awk '/ERROR SUMMARY:/ {print $4}' $WORKSPACE/test) -ne 0 ]; then
    error "Failure"
else
    echo "Success"
fi


TESTS=$(($(grep -c Success $0) - 2))

echo
echo "   Score $(echo "scale=4; ($TESTS - $FAILURES) / $TESTS.0 * $POINTS.0" | bc | awk '{printf "%0.2f\n", $1}') / 3.00"
printf "  Status "
if [ $FAILURES -gt 0 ]; then
    echo "Failure"
else
    echo "Success"
fi
echo
