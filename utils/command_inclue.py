import sys
import re
import glob
import pystache
import os

if len(sys.argv) > 1:
    commandsDirectoryPath = sys.argv[1]
    outputFilePath = sys.argv[2]  if len(sys.argv) > 2 else 'commands.inc'
    
    with open(outputFilePath, 'w') as includeFile:
        commands = []
        for r, d, f in os.walk(commandsDirectoryPath):
            for file in f:
                if '.pwn' in file:
                    commands.append(file[:-4])

        for command in commands:
            includeFile.write('#include \"cmd\\' + command + '.pwn\"\n')

        includeFile.write('\n')
        includeFile.write('InitCommands()\n')
        includeFile.write('{\n')
        for command in commands:
            includeFile.write('\tcommand_'+command+'();\n')
        includeFile.write('}\n')