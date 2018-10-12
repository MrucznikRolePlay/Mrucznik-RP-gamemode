#!/usr/bin/python

import glob
import sys
from chardet.universaldetector import UniversalDetector

path = ""
if(len(sys.argv) == 2):
    path = sys.argv[1]

detector = UniversalDetector()
detect = 0
for filename in glob.glob( path + '/**/*.pwn', recursive=True):
    detector.reset()
    for line in open(filename, 'rb'):
        detector.feed(line)
        if detector.done: break
    detector.close()

    if("utf-8" in detector.result['encoding'].lower()):
        print("Invalid file encoding: ", filename, detector.result['encoding'])
        detect = 1

sys.exit(detect)