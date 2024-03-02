#!/usr/bin/env python3

''' miles.py - Web crawler to download files in parallel. '''

from typing import Iterator, Optional

import os
import concurrent.futures
import itertools
import re
import sys
import tempfile
import time
import urllib.parse

import requests

# Constants

FILE_REGEX = {
    'jpg': [],  # TODO
    'mp3': [],  # TODO
    'pdf': [],  # TODO
    'png': [],  # TODO
}

MEGABYTES   = 1<<20
DESTINATION = '.'
CPUS        = 1

# Functions

def usage(exit_status: int=0) -> None:
    ''' Print usgae message and exit. '''
    print(f'''Usage: miles.py [-d DESTINATION -n CPUS -f FILETYPES] URL

Crawl the given URL for the specified FILETYPES and download the files to the
DESTINATION folder using CPUS cores in parallel.

    -d DESTINATION      Save the files to this folder (default: {DESTINATION})
    -n CPUS             Number of CPU cores to use (default: {CPUS})
    -f FILETYPES        List of file types: jpg, mp3, pdf, png (default: all)

Multiple FILETYPES can be specified in the following manner:

    -f jpg,png
    -f jpg -f png''', file=sys.stderr)
    sys.exit(exit_status)

def resolve_url(base: str, url: str) -> str:
    ''' Resolve absolute url from base url and possibly relative url.

    >>> base = 'https://www3.nd.edu/~pbui/teaching/cse.20289.sp24/'
    >>> resolve_url(base, 'static/img/ostep.jpg')
    'https://www3.nd.edu/~pbui/teaching/cse.20289.sp24/static/img/ostep.jpg'

    >>> resolve_url(base, 'https://automatetheboringstuff.com/')
    'https://automatetheboringstuff.com/'
    '''
    pass

def extract_urls(url: str, file_types: list[str]) -> Iterator[str]:
    ''' Extract urls of specified file_types from url.

    >>> url = 'https://www3.nd.edu/~pbui/teaching/cse.20289.sp24/'
    >>> extract_urls(url, ['jpg']) # doctest: +ELLIPSIS
    <generator object extract_urls at ...>

    >>> len(list(extract_urls(url, ['jpg'])))
    2
    '''
    pass

def download_url(url: str, destination: str=DESTINATION) -> Optional[str]:
    ''' Download url to destination folder.

    >>> url = 'https://www3.nd.edu/~pbui/teaching/cse.20289.sp24/static/img/ostep.jpg'
    >>> destination = tempfile.TemporaryDirectory()

    >>> path = download_url(url, destination.name)
    Downloading https://www3.nd.edu/~pbui/teaching/cse.20289.sp24/static/img/ostep.jpg...

    >>> path # doctest: +ELLIPSIS
    '/tmp/.../ostep.jpg'

    >>> os.stat(path).st_size
    53696

    >>> destination.cleanup()
    '''
    pass

def crawl(url: str, file_types: list[str], destination: str=DESTINATION, cpus: int=CPUS) -> None:
    ''' Crawl the url for the specified file type(s) and download all found
    files to destination folder.

    >>> url = 'https://www3.nd.edu/~pbui/teaching/cse.20289.sp24/'
    >>> destination = tempfile.TemporaryDirectory()
    >>> crawl(url, ['jpg'], destination.name) # doctest: +ELLIPSIS
    Files Downloaded: 2
    Bytes Downloaded: 0.07 MB
    Elapsed Time:     ... s
    Bandwidth:        0... MB/s

    >>> destination.cleanup()
    '''
    pass

# Main Execution

def main(arguments=sys.argv[1:]) -> None:
    ''' Process command line arguments, crawl URL for specified FILETYPES,
    download files to DESTINATION folder using CPUS cores.

    >>> url = 'https://www3.nd.edu/~pbui/teaching/cse.20289.sp24/'
    >>> destination = tempfile.TemporaryDirectory()
    >>> main(f'-d {destination.name} -f jpg {url}'.split()) # doctest: +ELLIPSIS
    Files Downloaded: 2
    Bytes Downloaded: 0.07 MB
    Elapsed Time:     0... s
    Bandwidth:        0... MB/s

    >>> destination.cleanup()
    '''
    pass

if __name__ == '__main__':
    main()
