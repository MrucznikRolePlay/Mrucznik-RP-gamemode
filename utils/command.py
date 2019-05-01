import sys
import re
import glob
import pystache
import os
import json


data = []
with open('command.json') as f:
    for line in f:
        data.append(json.loads(line))

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