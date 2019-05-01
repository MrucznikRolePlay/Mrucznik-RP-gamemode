from __future__ import print_function, unicode_literals
import sys
import re
import glob
import pystache
import os
import json
from argparse import ArgumentParser
from PyInquirer import prompt, print_json

# ------- config -------
groups = [
    {'name': 'everyone'},
    {'name': 'admin'},
    {'name': 'lspd'}
]

parameterTypes = [
    'player',
    'integer',
    'string',
    'float',
    'character'
]

parameterDefaultNames = {
    'player': 'giveplayerid'
}

parameterDefaultDescriptions = {
    'player': 'Nick/ID'
}

def getDefaultParameterName(param):
    return parameterDefaultNames.get(param, '')
    
def getDefaultParameterDescription(param):
    return parameterDefaultDescriptions.get(param, '')

# ------- modules -------
def create_module(args):
    print('Witaj w narzędziu tworzącym moduł mapy Mrucznik Role Play')
    questions = [
        {
            'type': 'input',
            'name': 'name',
            'message': 'Jak ma nazywać się moduł?',
        },
        {
            'type': 'input',
            'name': 'description',
            'message': 'Uzupełnij opis modułu:',
        },
        {
            'type': 'input',
            'name': 'description',
            'message': 'Uzupełnij opis modułu',
        }
    ]

    answers = prompt(questions)
    print(answers)

def generate_module(args):
    print("build module")

# ------- commands -------
def create_command(args):
    print('Witaj w narzędziu tworzącym komendę dla mapy Mrucznik Role Play')
    
    command = command_creator()
    commandName = '{}.json'.format(command['name'])
    with open(commandName, 'w') as file:
        json.dump(command, file, indent=4)
    print('Komenda pomyślnie utworzona jako plik {}'.format(commandName))

    answers = prompt([
        {
            'type': 'confirm',
            'name': 'build',
            'message': 'Czy chcesz wygenerować automatycznie kod pawn dla tej komendy?'

        }
    ])

    if(answers['build'] == True):
        print('ok')
    else:
        print('Nie generuje kodu pawn dla komendy. Aby zrobić to później, wpisz: mrucznikctl command build')

def command_creator():
    questions = [
        {
            'type': 'input',
            'name': 'name',
            'message': 'Jak ma nazywać się komenda?',
        },
        {
            'type': 'input',
            'name': 'description',
            'message': 'Wpisz opis komendy, który będzie widoczny dla graczy:',
        },
        {
            'type': 'checkbox',
            'name': 'permissions',
            'message': 'Wybierz, które grupy mają mieć dostęp do komendy:',
            'choices': groups
        },
        {
            'type': 'confirm',
            'name': 'aliases',
            'message': 'Czy komenda będzie miała dodatkowe aliasy?'
        }
    ]

    answers = prompt(questions)

    if(answers['aliases'] == True):
        answers['aliases'] = command_aliases()
    else:
        answers['aliases'] = []

    answers.update(prompt([
        {
            'type': 'confirm',
            'name': 'parameters',
            'message': 'Czy komenda będzie posiadała parametry?'
        }])
    )
    
    if(answers['parameters'] == True):
        answers['parameters'] = command_parameters()
    else:
        answers['parameters'] = []

    return answers

def command_aliases():
    aliases = []
    next = True
    while next:
        questions = [
            {
                'type': 'input',
                'name': 'alias',
                'message': 'Wpisz alias:',
            },
            {
                'type': 'confirm',
                'name': 'next',
                'message': 'Dodać następny alias?'
            }
        ]
        answers = prompt(questions)
        next = answers.pop('next')
        aliases.append(answers['alias'])
    
    return aliases

def command_parameters():
    parameters = []
    next = True
    while next:
        answers = prompt(
            {
                'type': 'list',
                'name': 'type',
                'message': 'Wybierz typ parametru:',
                'choices': parameterTypes
            },
        )

        answers.update(prompt([
            {
                'type': 'input',
                'name': 'name',
                'message': 'Wpisz nazwę parametru:',
                'default': getDefaultParameterName(answers['type'])
            },
            {
                'type': 'input',
                'name': 'description',
                'message': 'Wpisz opis parametru:',
                'default': getDefaultParameterDescription(answers['type'])
            },
            {
                'type': 'confirm',
                'name': 'default',
                'message': 'Czy parametr powinien mieć wartość domyślną?',
            }
        ]))

        if(answers.pop('default') == True):
            answers.update(prompt([
                {
                    'type': 'input',
                    'name': 'defaultValue',
                    'message': 'Wpisz wartość domyślną:'
                }
            ]))

        answers.update(prompt([
            {
                'type': 'confirm',
                'name': 'next',
                'message': 'Dodać następny parametr?'
            }
        ]))
        next = answers.pop('next')
        parameters.append(answers)

    return parameters


# ------- arguments -------
# create the top-level parser
parser = ArgumentParser(prog='mrucznikctl', description="Narzędzie do generowania kodu dla gamemodu Mrucznik Role Play")
subparsers = parser.add_subparsers(title='Dostępne opcje:', metavar='opcja', required=True)


# --- modules ---
parser_module = subparsers.add_parser('module', description='Zarządzanie modułami.', help='- zarządzanie modułami')
module_subparser = parser_module.add_subparsers(title='Dostępne działania', metavar='działanie', required=True)
# options
parser_create_module = module_subparser.add_parser('create', help='- tworzy moduł')
parser_create_module.set_defaults(func=create_module)

parser_generate_module = module_subparser.add_parser('build', help='- generuje kod modułu')
parser_generate_module.set_defaults(func=generate_module)

# --- commands ---
parser_command = subparsers.add_parser('command', description='Zarządzanie komendami.', help='- zarządzanie komendami')
command_subparser = parser_command.add_subparsers(title='Dostępne opcje', metavar='działanie', required=True)
# options
parser_create_command = command_subparser.add_parser('create', help='- tworzy nową komendę')
parser_create_command.set_defaults(func=create_command)


# parse arguments
args = parser.parse_args()
args.func(args)


# ------- builder -------
# na podstawie jsona generuje 2 pliki:
# command = nazwa komendy
# - command.pwn - wygenerowany kod z
#   - include "command_impl.pwn";
#   - command_Init() - do zainicjowania uprawnień komendy i aliasów
#   - command_PlayerInit() - opcjonalnie
#   - YCMD:command - zawierająca pobieranie parametrów przez sscanf oraz zawierającą wywołanie funkcji z pliku command_impl.pwn oraz wszelkie komunikaty itd.
# - command_impl.pwn - wygenerowana funkcja command_run(playerid, parametry)

# generator modułów dodatkowo dodaje:
# module.pwn
# - includowanie wszystkich komend modułu
# - module_Init() zawierającą wywołanie wszystkich funkcji command_Init()
# - module_PlayerInit() zawierającą wywołanie wszystkich funkcji command_PlayerInit()
# - plik module_impl.pwn gdzie zawarty jest kod własnoręcznie napisany

# łącznik modulów dodaje:
# modules.pwn
# - includowanie wszystkich modułów
# - modules_Init() zawierającą wywołanie wszystkich funkcji module_Init()
# - modules_PlayerInit() zawierającą wywołanie wszystkich funkcji module_PlayerInit()