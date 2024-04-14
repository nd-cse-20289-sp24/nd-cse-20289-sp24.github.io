#!/bin/bash

PROGRAM=timeit
WORKSPACE=/tmp/$PROGRAM.$(id -u)
FAILURES=0
POINTS=5

export PATH=$WORKSPACE:$PATH

# Functions

error() {
    echo "$@"
    [ -r $WORKSPACE/test ] && (echo; tail $WORKSPACE/test; ls -l $WORKSPACE; echo)
    FAILURES=$((FAILURES + 1))
}

cleanup() {
    STATUS=${1:-$FAILURES}
    rm -fr $WORKSPACE
    exit $STATUS
}

test_valgrind() {
    if [ $(awk '/ERROR SUMMARY:/ {errors += $4} END{print errors}' $WORKSPACE/test) -ne 0 ]; then
	error "Failure"
    else
	echo "Success"
    fi
}

test_output() {
    ttime="$(awk '/Time Elapsed:/ {print $3}' $WORKSPACE/test)"
    if ! echo "$ttime" | grep -q -P "$1"; then
    	echo "Wrong time: $ttime != $1" >> $WORKSPACE/test
	error "Failure"
    else
	echo "Success"
    fi
}

grep_all() {
    for pattern in $1; do
    	if ! grep -q -E "$pattern" $2; then
    	    echo "Missing $pattern in $2" >> $WORKSPACE/test
    	    return 1;
    	fi
    done
    return 0;
}

SYSCALLS="fork exec[vl]p (wait|waitpid) (signal|sigaction) (nanosleep|sleep|alarm) clock_gettime WIFEXITED WEXITSTATUS WTERMSIG"

# Setup

mkdir $WORKSPACE

trap "cleanup" EXIT
trap "cleanup 1" INT TERM

# Testing

echo "Testing $PROGRAM..."

printf " %-72s ... " "system calls"
if ! grep_all "$SYSCALLS" $PROGRAM.c; then
    error "Failure"
else
    echo "Success"
fi

printf " %-72s ... " "usage (-h)"
PATTERNS="usage"
valgrind --leak-check=full ./$PROGRAM -h &> $WORKSPACE/test
if [ $? -ne 0 ] || ! grep_all "$PATTERNS" $WORKSPACE/test; then
    error "Failure"
else
    echo "Success"
fi
printf " %-72s ... " "usage (-h, valgrind)" && test_valgrind

printf " %-72s ... " "usage (no arguments)"
PATTERNS="usage"
valgrind --leak-check=full ./$PROGRAM &> $WORKSPACE/test
if [ $? -ne 1 ] || ! grep_all "$PATTERNS" $WORKSPACE/test; then
    error "Failure"
else
    echo "Success"
fi
printf " %-72s ... " "usage (no arguments, valgrind)" && test_valgrind

printf " %-72s ... " "usage (-v, no command)"
PATTERNS="usage Timeout Verbose"
valgrind --leak-check=full ./$PROGRAM -v &> $WORKSPACE/test
if [ $? -ne 1 ] || ! grep_all "$PATTERNS" $WORKSPACE/test; then
    error "Failure"
else
    echo "Success"
fi
printf " %-72s ... " "usage (-v, no command, valgrind)" && test_valgrind

printf " %-72s ... " "usage (-t 5 -v, no command)"
PATTERNS="usage Timeout Verbose"
valgrind --leak-check=full ./$PROGRAM -t 5 -v &> $WORKSPACE/test
if [ $? -ne 1 ] || ! grep_all "$PATTERNS" $WORKSPACE/test; then
    error "Failure"
else
    echo "Success"
fi
printf " %-72s ... " "usage (-t 5 -v, no command, valgrind)" && test_valgrind

printf " %-72s ... " "sleep"
valgrind --leak-check=full ./$PROGRAM sleep &> $WORKSPACE/test
if [ $? -ne 1 ]; then
    error "Failure"
else
    echo "Success"
fi
printf " %-72s ... " "sleep (valgrind)" && test_valgrind

printf " %-72s ... " "sleep 1"
PATTERNS="Elapsed"
valgrind --leak-check=full ./$PROGRAM sleep 1 &> $WORKSPACE/test
if [ $? -ne 0 ] || ! grep_all "$PATTERNS" $WORKSPACE/test; then
    error "Failure"
else
    echo "Success"
fi
printf " %-72s ... " "sleep 1 (output)"   && test_output 1.\\d
printf " %-72s ... " "sleep 1 (valgrind)" && test_valgrind

printf " %-72s ... " "-v sleep 1"
PATTERNS="Timeout Verbose Registering handlers Grabbing start time Sleeping Executing Waiting exit Elapsed"
valgrind --leak-check=full ./$PROGRAM -v sleep 1 &> $WORKSPACE/test
if [ $? -ne 0 ] || ! grep_all "$PATTERNS" $WORKSPACE/test; then
    error "Failure"
else
    echo "Success"
fi
printf " %-72s ... " "-v sleep 1 (output)"   && test_output 1.\\d
printf " %-72s ... " "-v sleep 1 (valgrind)" && test_valgrind

printf " %-72s ... " "-t 5 -v sleep 1"
PATTERNS="Timeout Verbose Registering handlers Grabbing start time Sleeping Executing Waiting exit Elapsed"
valgrind --leak-check=full ./$PROGRAM -t 5 -v sleep 1 &> $WORKSPACE/test
if [ $? -ne 0 ] || ! grep_all "$PATTERNS" $WORKSPACE/test; then
    error "Failure"
else
    echo "Success"
fi
printf " %-72s ... " "-t 5 -v sleep 1 (output)"   && test_output 1.\\d
printf " %-72s ... " "-t 5 -v sleep 1 (valgrind)" && test_valgrind

printf " %-72s ... " "sleep 5"
valgrind --leak-check=full ./$PROGRAM sleep 5 &> $WORKSPACE/test
if [ $? -ne 0 ]; then
    error "Failure"
else
    echo "Success"
fi
printf " %-72s ... " "sleep 5 (output)"   && test_output 5.\\d
printf " %-72s ... " "sleep 5 (valgrind)" && test_valgrind

printf " %-72s ... " "-v sleep 5"
PATTERNS="Timeout Verbose Registering handlers Grabbing start time Sleeping Executing Waiting exit Elapsed"
valgrind --leak-check=full ./$PROGRAM -v sleep 5 &> $WORKSPACE/test
if [ $? -ne 0 ] || ! grep_all "$PATTERNS" $WORKSPACE/test; then
    error "Failure"
else
    echo "Success"
fi
printf " %-72s ... " "-v sleep 5 (output)"   && test_output 5.\\d
printf " %-72s ... " "-v sleep 5 (valgrind)" && test_valgrind

printf " %-72s ... " "-t 1 sleep 5"
PATTERNS="Elapsed"
valgrind --leak-check=full ./$PROGRAM -t 1 sleep 5 &> $WORKSPACE/test
if [ $? -ne 9 ] || ! grep_all "$PATTERNS" $WORKSPACE/test; then
    error "Failure"
else
    echo "Success"
fi
printf " %-72s ... " "-t 1 sleep 5 (output)"   && test_output 1.\\d
printf " %-72s ... " "-t 1 sleep 5 (valgrind)" && test_valgrind

printf " %-72s ... " "-t 1 -v sleep 5"
PATTERNS="Timeout Verbose Registering handlers Grabbing start time Sleeping Executing Waiting exit Elapsed Killing"
valgrind --leak-check=full ./$PROGRAM -t 1 -v sleep 5 &> $WORKSPACE/test
if [ $? -ne 9 ] || ! grep_all "$PATTERNS" $WORKSPACE/test; then
    error "Failure"
else
    echo "Success"
fi
printf " %-72s ... " "-t 1 -v sleep 5 (output)"   && test_output 1.\\d
printf " %-72s ... " "-t 1 -v sleep 5 (valgrind)" && test_valgrind

printf " %-72s ... " "-v find /etc -type f"
PATTERNS="Timeout Verbose Registering handlers Grabbing start time Sleeping Executing Waiting exit Elapsed"
valgrind --leak-check=full ./$PROGRAM -v find /etc -type f &> $WORKSPACE/test
if [ $? -ne 1 ] || ! grep_all "$PATTERNS" $WORKSPACE/test; then
    error "Failure"
else
    echo "Success"
fi
printf " %-72s ... " "-v find /etc -type f (output)"   && test_output 0.\\d
printf " %-72s ... " "-v find /etc -type f (valgrind)" && test_valgrind

TESTS=$(($(grep -c Success $0) - 1 + $(grep -c test_valgrind $0) - 2))
echo
echo "   Score $(echo "scale=4; ($TESTS - $FAILURES) / $TESTS.0 * $POINTS.0" | bc | awk '{ printf "%0.2f\n", $1 }' ) / $POINTS.00"
printf "  Status "
if [ $FAILURES -eq 0 ]; then
    echo "Success"
else
    echo "Failure"
fi
echo
