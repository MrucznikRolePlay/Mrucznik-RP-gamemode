import sys
import re
import glob
import pystache
import os
import json

from argparse import ArgumentParser

def create():
    print("create")

def generate():
    print("generate")

# --- arguments ---
# create the top-level parser
parser = ArgumentParser(prog='mrucznikctl', description="Narzędzie do generowania kodu dla gamemodu Mrucznik Role Play")
subparsers = parser.add_subparsers(title='Komendy')

# create the mid-level parsers
parser_module = subparsers.add_parser('module', description='Zarządzanie modułami.', help='- zarządzanie modułami')
module_subparser = parser_module.add_subparsers(title='Dostępne opcje')

# create the third-level parsers
parser_create = module_subparser.add_parser('create', help='- tworzy moduł')
parser_create.add_argument('y', type=float)
parser_create.set_defaults(func=create)

parser_generate = module_subparser.add_parser('generate', help='- generuje kod modułu')
parser_generate.set_defaults(func=generate)

# parser.add_argument('--sum', dest='accumulate', action='store_const',
#                     const=sum, default=max,
#                     help='sum the integers (default: find the max)')
# parser.add_argument("-f", "--file", dest="filename",
#                     help="write report to FILE", metavar="FILE")
# parser.add_argument("-q", "--quiet",
#                     action="store_false", dest="verbose", default=True,
#                     help="don't print status messages to stdout")

args = parser.parse_args()
print("ARGS: ")
print(args)