#!/usr/bin/env python

"""
This script downloads all the song files from the URLs included in the
id_index_internetarchive.csv file contained in the SALAMI data set.

The downloaded files will be saved as song_id.mp3.

Usage:
    python SALAMI_download.py csv_file output_dir

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
"""

import os
import argparse
import urllib2
import csv

__author__ = "Oriol Nieto"
__copyright__ = "Copyright 2012, SALAMI Data Set Project"
__license__ = "GPL"
__version__ = "1.0"
__email__ = "oriol@nyu.edu"

def download(url, localName):
    """Downloads the file from the url and saves it as localName."""
    req = urllib2.Request(url)
    r = urllib2.urlopen(req)
    f = open(localName, 'wb')
    f.write(r.read())
    f.close()

def process( csv_file, output_dir ):
    """Main process function to download all mp3s from the csv_file
    and put thm in the ouput_dir."""
    f = open( csv_file, "r" )
    file_reader = csv.reader(f)
    for fields in file_reader:
        id = fields[0]
        url = fields[4]
        print "Downloading: ", id, url
        try:
            download( url, os.path.join(output_dir, id + ".mp3") )
        except Exception,e:
            print "Could not retrieve:", id, url
            print "Exception:", e
    f.close()

def main():
    """Main function to parse the arguments and call the main process."""
    parser = argparse.ArgumentParser(description=
             'Evaluates the results of the analyzer with the '\
             'ground truth data.')
    parser.add_argument('csv_file', action='store',
                        help='The path to id_index_internetarchive.csv')
    parser.add_argument('output_dir', action='store',
                        help='Directory where to save all the mp3s')
    args = parser.parse_args()
    process(args.csv_file, args.output_dir)

if __name__ == "__main__":
    main()
