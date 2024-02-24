#!/usr/bin/env python3

''' namez.py - Baby Names Table '''

import csv
import gzip
import sys

# Constants

PATH = 'namez.input.gz'

# Types

Database = dict[int, dict[str, int]]

# Functions

def usage(exit_status: int=0) -> None:
    ''' Print usage message and exit. '''
    print(f'''Usage: namez.py [-p -y YEARS] NAMES

Print the counts for each NAME in the corresponding YEARS.

    -p          Show percentages instead of counts
    -y YEARS    Only display these YEARS (default: all)

YEARS may be specified multiple times and can be a single year, or a list
separated by commas, or a range separated by -:

    -y 2002 -y 2003 -y 2004
    -y 2002,2003,2004
    -y 2002-2004

The YEARS are always displayed in ascending order, while the NAMES are
displayed in the order provided.''', file=sys.stderr)
    sys.exit(exit_status)

def load_database(path: str=PATH) -> Database:
    ''' Returns dictionary that maps years to a dictionary with names mapped to
    counts: {YEAR: {NAME: COUNT}}

    >>> database = load_database('namez.input.test.gz')
    >>> len(database)
    143

    >>> len(database[2002])
    108

    >>> database[2004]['Mary']
    4855
    '''
    pass

def print_table(database: Database, years: list[int]=[], names: list[str]=[], percentage=False) -> None:
    ''' Prints table of years and names (along with their counts or percentages).

    >>> database = load_database('namez.input.test.gz')
    >>> print_table(database, [2000, 2001, 2002, 2003], ['Anna', 'Mary'])
    Year        Anna        Mary
    2000       10618        6225
    2001       10595        5766
    2002       10402        5491
    2003        9467        5041
    '''
    pass

# Main Execution

def main(arguments=sys.argv[1:]) -> None:
    ''' Processes command line arguments and prints a table of years and names
    (along with their counts or percentages.

    >>> main('-y 2000-2003 Anna Mary'.split())
    Year        Anna        Mary
    2000       10618        6225
    2001       10595        5766
    2002       10402        5491
    2003        9467        5041
    '''
    pass

if __name__ == '__main__':
    main()

# vim: set sts=4 sw=4 ts=8 expandtab ft=python:
