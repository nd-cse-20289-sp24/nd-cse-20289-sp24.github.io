#!/bin/bash

WORKSPACE=/tmp/str_rev.$(id -u)
FAILURES=0

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

mkdir $WORKSPACE

trap "cleanup" EXIT
trap "cleanup 1" INT TERM

echo "Checking reading10 str_rev ..."

printf " %-40s ... " "str_rev (no arguments)"
./str_rev | diff -y - <(true) > $WORKSPACE/test
if [ $? -ne 0 ]; then
    error "Failure"
else
    echo "Success"
fi

printf " %-40s ... " "str_rev (no arguments) (valgrind)"
valgrind --leak-check=full ./str_rev &> $WORKSPACE/test
if [ $? -ne 0 ] || [ "$(awk '/ERROR SUMMARY/ {print $4}' $WORKSPACE/test)" -ne 0 ]; then
    error "Failure"
else
    echo "Success"
fi

printf " %-40s ... " "str_rev old school"
./str_rev old school | diff -y - <(printf "dlo\nloohcs\n") > $WORKSPACE/test
if [ $? -ne 0 ]; then
    error "Failure"
else
    echo "Success"
fi

printf " %-40s ... " "str_rev old school (valgrind)"
valgrind --leak-check=full ./str_rev old school &> $WORKSPACE/test
if [ $? -ne 0 ] || [ "$(awk '/ERROR SUMMARY/ {print $4}' $WORKSPACE/test)" -ne 0 ]; then
    error "Failure"
else
    echo "Success"
fi

printf " %-40s ... " "str_rev 'old school'"
./str_rev 'old school' | diff -y - <(printf "loohcs dlo\n") > $WORKSPACE/test
if [ $? -ne 0 ]; then
    error "Failure"
else
    echo "Success"
fi

printf " %-40s ... " "str_rev 'old school' (valgrind)"
valgrind --leak-check=full ./str_rev 'old school' &> $WORKSPACE/test
if [ $? -ne 0 ] || [ "$(awk '/ERROR SUMMARY/ {print $4}' $WORKSPACE/test)" -ne 0 ]; then
    error "Failure"
else
    echo "Success"
fi

TESTS=$(($(grep -c Success $0) - 2))
echo
echo "   Score $(echo "scale=4; ($TESTS - $FAILURES) / $TESTS.0 * 2.0" | bc | awk '{printf "%0.2f\n", $0}') / 2.00"
printf "  Status "
if [ $FAILURES -eq 0 ]; then
    echo "Success"
else
    echo "Failure"
fi
echo
