#!/usr/bin/env python3

import collections
import re
import requests

# Constants

URL = 'https://www3.nd.edu/~pbui/teaching/'

# Functions

def count_items(item: tuple[str, int]) -> tuple[int, str]:
    ''' Returns tuple with negative count, and course name. '''
    return (-item[1], item[0])

# Main Execution

def main() -> None:
    # TODO: Initialize a empty dictionary that maps strings to ints
    counts = None

    # TODO: Make a HTTP request to URL
    response = None

    # TODO: Access text from response object
    data = None

    # TODO: Compile regular expression to match CSE courses (ie. CSE XXXXX)
    regex = re.compile(None)

    # TODO: Count occurrences of each course found in data
    for course in re.findall(None, None):
        pass

    # TODO: Sort items in counts dictionary with count_items key function
    for course, count in sorted(None, key=None):
        print(f'{count:>7} {course}')

if __name__ == '__main__':
    main()
