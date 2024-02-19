#!/usr/bin/env python3

import csv

# Constants

PATH = '/etc/passwd'

# Main Execution

def main() -> None:
    # TODO: Loop through ':' delimited data in PATH, extract the seventh field
    # (shell), and add it to a set
    shells = None
    for record in csv.reader(None, None):
        pass

    # TODO: Print only unique shells in sorted order
    for shell in sorted(shells):
        pass

if __name__ == '__main__':
    main()
