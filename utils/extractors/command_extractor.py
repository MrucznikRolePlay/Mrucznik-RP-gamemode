import sys
import re
import glob
import pystache
import os

renderer = pystache.Renderer(escape=lambda u: u)

def centerCommandName(commandName):
	return "//" + ("[ " + commandName + " ]").center(107, '-') + "//"

def saveCommand(aggregatedLines, commandName):
	if aggregatedLines != "":
		with open('commands/' + commandName + '.pwn', 'w') as commandFile:
			commandFile.write(renderer.render(templateText, {'commandName': centerCommandName(commandName), 'command': aggregatedLines }, string_encoding='ANSI'))


if len(sys.argv) > 2:
	filePath = sys.argv[1]
	templatePath = sys.argv[2]
	
	if not os.path.exists('commands'):
		os.makedirs('commands')
	
	with open(filePath, 'r') as mainFile, open(templatePath, 'r') as templateFile, open('include_commands.pwn', 'w') as includeFile:
		templateText = templateFile.read()
		aggregatedLines = ""
		commandName = ""
		aliasy = ""
	
		while True:
			line = mainFile.readline()
			if not line:
				saveCommand(aggregatedLines, commandName)
				break
				
			if line.startswith('CMD:'):
				if aliasy == "":
					saveCommand(aggregatedLines, commandName)
				if line.find('return') >= 1:
					aliasy += line
				else:
					commandName = line[4:line.find('(')]
					includeFile.write('#include \"_PATH_\\' + commandName + '.pwn\"\n')
					aggregatedLines = aliasy + line
					aliasy = ""
			else:
				aggregatedLines += line
else:
	print("Brak sciezki do pliku i/lub szablonu w argumentach wywolania")
	print("Użyj: python command_extractor.py [plik z komendami] [plik z szablonem komendy w mustache]")