from __future__ import print_function, unicode_literals
import sys
import re
import glob
import os
import json
import regex
from jinja2 import Environment, PackageLoader, select_autoescape
from argparse import ArgumentParser
from PyInquirer import prompt, print_json
from PyInquirer import Validator, ValidationError

env = Environment(
    loader=PackageLoader('mrucznikctl', 'templates')
)

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

parameterSymbols = {
    'player': 'r',
    'integer': 'd',
    'string': 's',
    'float': 'f',
    'character': 'c'
}

parameterVariablePrefixes = {
    'float': 'Float:'
}

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

# ------- validators -------
class NameValidator(Validator):
    def validate(self, document):
        ok = regex.match('^[a-z_]*$', document.text)
        if not ok:
            raise ValidationError(
                message='Nazwa musi zawierać tylko małe litery oraz "_"',
                cursor_position=len(document.text))
                
class VariableValidator(Validator):
    def validate(self, document):
        ok = regex.match('^[a-z0-9_]*$', document.text)
        if not ok:
            raise ValidationError(
                message='Nazwa zmiennej musi być w formacie camelCase',
                cursor_position=len(document.text))

# ------- modules -------
def create_module(args):
    print('Witaj w narzędziu tworzącym moduł mapy Mrucznik Role Play')

    questions = [
        {
            'type': 'input',
            'name': 'name',
            'message': 'Jak ma nazywać się moduł?',
            'validate': NameValidator
        },
        {
            'type': 'input',
            'name': 'description',
            'message': 'Uzupełnij opis modułu:',
        },
        {
            'type': 'input',
            'name': 'author',
            'message': 'Kto jest autorem modułu?'
        },
        {
            'type': 'confirm',
            'name': 'commands',
            'message': 'Czy chcesz dodać komendy do modułu?'
        }
    ]

    answers = prompt(questions)
    if answers.pop('commands') == True:
        answers['commands'] = []
        next = True
        while next:
            answers['commands'].append(create_command(args)['name'])
            next = prompt([{
                'type': 'confirm',
                'name': 'next',
                'message': 'Czy chcesz dodać kolejną komendę?'
            }])['next']
    else:
        answers['commands'] = {}
    
    moduleName = '{}.json'.format(answers['name'])
    with open(moduleName, 'w') as file:
        json.dump(answers, file, indent=4)
    print('Moduł pomyślnie utworzony jako plik {}'.format(moduleName))

# ------- commands -------
def create_command(args):
    print('Witaj w narzędziu tworzącym komendę dla mapy Mrucznik Role Play')
    
    command = command_creator()
    commandName = '{}.json'.format(command['name'])
    with open(commandName, 'w') as file:
        json.dump(command, file, indent=4)
    print('Komenda pomyślnie utworzona jako plik {}'.format(commandName))

    return command

def command_creator():
    questions = [
        {
            'type': 'input',
            'name': 'name',
            'message': 'Jak ma nazywać się komenda?',
            'validate': NameValidator
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
            'type': 'input',
            'name': 'author',
            'message': 'Kto jest autorem komendy?'
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
                'validate': NameValidator
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

        questions = []
        if(answers['type'] == 'string'):
            questions.append({
                {
                    'type': 'input',
                    'name': 'size',
                    'message': 'Wpisz rozmiar ciągu znaków:',
                    'default': getDefaultParameterDescription(answers['type'])
                },
            })

        questions.append([
            {
                'type': 'input',
                'name': 'name',
                'message': 'Wpisz nazwę parametru:',
                'default': getDefaultParameterName(answers['type']),
                'validate': VariableValidator
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
        ])

        answers.update(prompt(questions))

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

# ------- code generation -------
def generate_code(args):
    with open('telefon.json') as commandFile:
        commandJson = json.load(commandFile)
        prepareParameters(commandJson['parameters'])
        generate_command(commandJson)
    
def generate_command(commandData):
    command = env.get_template('command.pwn.jinja2')
    command_impl = env.get_template('command_impl.pwn.jinja2')

    print(command.render(commandData))
    print(command_impl.render(commandData))
    
def generate_module():
    print('generate command')

def generate_modules_inc():
    print('generate command')

def generate_commands_inc():
    print('generate command')

def prepareParameters(parameters):
    for parameter in parameters:
        parameter['variable'] = generateParameterVariableName(parameter)
        parameter['symbol'] = generateParameterSymbol(parameter)

def generateParameterVariableName(parameter):
    paramPrefix = parameterVariablePrefixes.get(parameter['type'], '')
    if('size' in parameter):
        return "{}{}[{}]".format(paramPrefix, parameter['name'], parameter['size'])
    return "{}{}".format(paramPrefix, parameter['name'])

def generateParameterSymbol(parameter):
    symbol = parameterSymbols[parameter['type']]
    if('defaultValue' in parameter):
        symbol = '{}({})'.format(symbol.upper(), parameter['defaultValue'])
    if('size' in parameter):
        symbol = '{}[{}]'.format(symbol, parameter['size'])
    return symbol

# ------- check configuration -------

# struktura mapy mrucznika
# legenda: 
# A - kod generowany automatycznie
# T - szablon
# Mrucznik-RP.pwn
# - modules
#   - modules.json - zawiera spis wszystkich modułów
#   - modules.pwn A
#   - przykładowy_moduł
#       - przykładowy_moduł.json
#       - przykładowy_moduł.def T
#       - przykładowy_moduł.hwn T
#       - przykładowy_moduł.pwn T
#       - commands
#           - commands.pwn A
#           - przykładowa komenda
#               - command.json
#               - command.pwn A
#               - command_impl.pwn T
#       - dialogs
def check_configuration(args):
    assert(os.path.isdir('./modules'))
    assert(os.path.exists('./modules/modules.json'))
    # all modules in modules.json check
    with open('./modules/modules.json') as modules_json:  
        jsonData = json.load(modules_json)
        for modules in jsonData['modules']:
            module_name = modules['name']
            module_filename = './modules/{0}/{0}.json'.format(module_name)
            assert(os.path.isdir('./modules/{}'.format(module_name)))
            assert(os.path.exists(module_filename))
            with open(module_filename) as module_file:
                module_json = json.load(module_file)
                assert(os.path.isdir('./modules/{}/commands'.format(module_name)))
                for command in module_json['commands']:
                    command_name = command['name']
                    assert(os.path.isdir('./modules/{}/commands/{}'.format(module_name, command_name)))
                    assert(os.path.exists('./modules/{0}/commands/{1}/{1}.json'.format(module_name, command_name)))

    print('all ok')
    # TODO: checking for unlisted files

# ------- arguments -------
# create the top-level parser
parser = ArgumentParser(prog='mrucznikctl', description="Narzędzie do generowania kodu dla gamemodu Mrucznik Role Play")
subparsers = parser.add_subparsers(title='Dostępne opcje:', metavar='opcja', required=True)


# --- create ---
opcja_create = subparsers.add_parser('create', description='Tworzenie komponentów mapy.', help='- tworzenie komponentów mapy')
subparser_create = opcja_create.add_subparsers(title='Dostępne komponenty', metavar='komponenty', required=True)
# options
parser_create_module = subparser_create.add_parser('module', help='- tworzy moduł')
parser_create_module.set_defaults(func=create_module)
parser_create_command = subparser_create.add_parser('command', help='- tworzy nową komendę')
parser_create_command.set_defaults(func=create_command)

# --- build ---
parser_build = subparsers.add_parser('build', description='Generuje kod na podstawie plików json.', help='- generowanie kodu')
parser_build.set_defaults(func=generate_code)

# --- ensure ---
parser_build = subparsers.add_parser('check', description='Sprawdza, czy konfiguracja mapy jest poprawna.', help='- sprawdzanie konfiguracji')
parser_build.set_defaults(func=check_configuration)

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

# TODO: Problem z polskimi znakami w generowanych plikach JSON

