#!/bin/bash

WORKSPACE=/tmp/reading06.$(id -u)
FAILURES=0

# Functions

error() {
    echo "$1"
    echo
    [ -r $WORKSPACE/test ] && cat $WORKSPACE/test
    echo
    FAILURES=$((FAILURES + $2))
}

cleanup() {
    STATUS=${1:-$FAILURES}
    rm -fr $WORKSPACE
    exit $STATUS
}

courses_sh() {
    curl -sL https://www3.nd.edu/~pbui/teaching/ | grep -Eo 'CSE [234][0-9]{4}' | sort | uniq -c | sort -rsn
}

shells_sh() {
    cat /etc/passwd | cut -d : -f 7 | sort | uniq
}

machines_sh() {
    curl -sL http://catalog.cse.nd.edu:9097/query.json | sed -En 's/\{"name":"([^"]+)".*"address":"([^"]+)".*"type":"chirp".*/\1 \2/p'
}

# Main Execution

mkdir $WORKSPACE

trap "cleanup" EXIT
trap "cleanup 1" INT TERM

echo "Testing reading06 scripts..."

printf " %-40s ... " "courses.py"
diff -u <(./courses.py) <(courses_sh) &> $WORKSPACE/test
if [ $? -ne 0 ]; then
    error "Failure" 2
else
    echo "Success"
fi

printf " %-40s ... " "shells.py"
diff -u <(./shells.py) <(shells_sh) &> $WORKSPACE/test
if [ $? -ne 0 ]; then
    error "Failure" 1
else
    echo "Success"
fi

printf " %-40s ... " "machines.py"
diff -u <(./machines.py) <(machines_sh) &> $WORKSPACE/test
if [ $? -ne 0 ]; then
    error "Failure" 1
else
    echo "Success"
fi

TESTS=$(($(grep -c Success $0) - 1))
echo
echo "   Score $(echo "scale=4; ($TESTS - $FAILURES) / $TESTS.0 * 4.0" | bc | awk '{printf "%0.2f\n", $1}') / 4.00"
printf "  Status "
if [ $FAILURES -eq 0 ]; then
    echo "Success"
else
    echo "Failure"
fi
echo
