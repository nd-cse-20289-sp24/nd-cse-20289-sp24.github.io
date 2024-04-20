#!/bin/bash

PROGRAM=nmapit
WORKSPACE=/tmp/$PROGRAM.$(id -u)
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

nmapfr() {
    nmap $ARGUMENTS | grep open | cut -d / -f 1
}

mkdir $WORKSPACE

trap "cleanup" EXIT
trap "cleanup 1" INT TERM

echo "Testing $PROGRAM utility..."

#------------------------------------------------------------------------------

printf " %-60s ... " "$PROGRAM"
./$PROGRAM &> $WORKSPACE/test
if [ $? -eq 0 ]; then
    error "Failure"
else
    echo "Success"
fi

printf " %-60s ... " "$PROGRAM (valgrind)"
valgrind --leak-check=full ./$PROGRAM &> $WORKSPACE/test
if [ $? -eq 0 ] || [ $(awk '/ERROR SUMMARY:/ {print $4}' $WORKSPACE/test) -ne 0 ]; then
    error "Failure"
else
    echo "Success"
fi

#------------------------------------------------------------------------------

ARGUMENTS="-h"

printf " %-60s ... " "$PROGRAM $ARGUMENTS"
./$PROGRAM $ARGUMENTS |& grep -q -i usage &> $WORKSPACE/test
if [ $? -ne 0 ]; then
    error "Failure"
else
    echo "Success"
fi

printf " %-60s ... " "$PROGRAM $ARGUMENTS (valgrind)"
valgrind --leak-check=full ./$PROGRAM $ARGUMENTS &> $WORKSPACE/test
if [ $? -ne 0 ] || [ $(awk '/ERROR SUMMARY:/ {print $4}' $WORKSPACE/test) -ne 0 ]; then
    error "Failure"
else
    echo "Success"
fi

#------------------------------------------------------------------------------

ARGUMENTS="-p 9000"

printf " %-60s ... " "$PROGRAM $ARGUMENTS"
./$PROGRAM $ARGUMENTS |& grep -q -i usage &> $WORKSPACE/test
if [ $? -ne 0 ]; then
    error "Failure"
else
    echo "Success"
fi

printf " %-60s ... " "$PROGRAM $ARGUMENTS (valgrind)"
valgrind --leak-check=full ./$PROGRAM $ARGUMENTS &> $WORKSPACE/test
if [ $? -eq 0 ] || [ $(awk '/ERROR SUMMARY:/ {print $4}' $WORKSPACE/test) -ne 0 ]; then
    error "Failure"
else
    echo "Success"
fi

#------------------------------------------------------------------------------

ARGUMENTS="-p 9000-"

printf " %-60s ... " "$PROGRAM $ARGUMENTS"
./$PROGRAM $ARGUMENTS |& grep -q -i usage &> $WORKSPACE/test
if [ $? -ne 0 ]; then
    error "Failure"
else
    echo "Success"
fi

printf " %-60s ... " "$PROGRAM $ARGUMENTS (valgrind)"
valgrind --leak-check=full ./$PROGRAM $ARGUMENTS &> $WORKSPACE/test
if [ $? -eq 0 ] || [ $(awk '/ERROR SUMMARY:/ {print $4}' $WORKSPACE/test) -ne 0 ]; then
    error "Failure"
else
    echo "Success"
fi

#------------------------------------------------------------------------------

ARGUMENTS="-p -9000"

printf " %-60s ... " "$PROGRAM $ARGUMENTS"
./$PROGRAM $ARGUMENTS |& grep -q -i usage &> $WORKSPACE/test
if [ $? -ne 0 ]; then
    error "Failure"
else
    echo "Success"
fi

printf " %-60s ... " "$PROGRAM $ARGUMENTS (valgrind)"
valgrind --leak-check=full ./$PROGRAM $ARGUMENTS &> $WORKSPACE/test
if [ $? -eq 0 ] || [ $(awk '/ERROR SUMMARY:/ {print $4}' $WORKSPACE/test) -ne 0 ]; then
    error "Failure"
else
    echo "Success"
fi

#------------------------------------------------------------------------------

ARGUMENTS="xavier.h4x0r.space"

printf " %-60s ... " "$PROGRAM $ARGUMENTS"
diff -y <(./$PROGRAM $ARGUMENTS) <(nmapfr $ARGUMENTS) &> $WORKSPACE/test
if [ $? -ne 0 ]; then
    error "Failure"
else
    echo "Success"
fi

printf " %-60s ... " "$PROGRAM $ARGUMENTS (valgrind)"
valgrind --leak-check=full ./$PROGRAM $ARGUMENTS &> $WORKSPACE/test
if [ $? -ne 0 ] || [ $(awk '/ERROR SUMMARY:/ {print $4}' $WORKSPACE/test) -ne 0 ]; then
    error "Failure"
else
    echo "Success"
fi

#------------------------------------------------------------------------------

ARGUMENTS="-p 9000-9999 xavier.h4x0r.space"

printf " %-60s ... " "$PROGRAM $ARGUMENTS"
diff -y <(./$PROGRAM $ARGUMENTS) <(nmapfr $ARGUMENTS) &> $WORKSPACE/test
if [ $? -ne 0 ]; then
    error "Failure"
else
    echo "Success"
fi

printf " %-60s ... " "$PROGRAM $ARGUMENTS (valgrind)"
valgrind --leak-check=full ./$PROGRAM $ARGUMENTS &> $WORKSPACE/test
if [ $? -ne 0 ] || [ $(awk '/ERROR SUMMARY:/ {print $4}' $WORKSPACE/test) -ne 0 ]; then
    error "Failure"
else
    echo "Success"
fi

#------------------------------------------------------------------------------

ARGUMENTS="-p 9005-9010 weasel.h4x0r.space"

printf " %-60s ... " "$PROGRAM $ARGUMENTS"
diff -y <(./$PROGRAM $ARGUMENTS) <(nmapfr $ARGUMENTS) &> $WORKSPACE/test
if [ $? -ne 0 ]; then
    error "Failure"
else
    echo "Success"
fi

printf " %-60s ... " "$PROGRAM $ARGUMENTS (valgrind)"
valgrind --leak-check=full ./$PROGRAM $ARGUMENTS &> $WORKSPACE/test
if [ $? -eq 0 ] || [ $(awk '/ERROR SUMMARY:/ {print $4}' $WORKSPACE/test) -ne 0 ]; then
    error "Failure"
else
    echo "Success"
fi

#------------------------------------------------------------------------------

ARGUMENTS="-p 9895-9900 weasel.h4x0r.space"

printf " %-60s ... " "$PROGRAM $ARGUMENTS"
diff -y <(./$PROGRAM $ARGUMENTS) <(nmapfr $ARGUMENTS) &> $WORKSPACE/test
if [ $? -ne 0 ]; then
    error "Failure"
else
    echo "Success"
fi

printf " %-60s ... " "$PROGRAM $ARGUMENTS (valgrind)"
valgrind --leak-check=full ./$PROGRAM $ARGUMENTS &> $WORKSPACE/test
if [ $? -ne 0 ] || [ $(awk '/ERROR SUMMARY:/ {print $4}' $WORKSPACE/test) -ne 0 ]; then
    error "Failure"
else
    echo "Success"
fi

#------------------------------------------------------------------------------

TESTS=$(($(grep -c Success $0) - 2))

echo
echo "   Score $(echo "scale=4; ($TESTS - $FAILURES) / $TESTS.0 * $POINTS.0" | bc | awk '{printf "%0.2f\n", $1}') / $POINTS.00"
printf "  Status "
if [ $FAILURES -gt 0 ]; then
    echo "Failure"
else
    echo "Success"
fi
echo
