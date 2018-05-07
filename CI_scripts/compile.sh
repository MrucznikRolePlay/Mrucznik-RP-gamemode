#!/bin/bash

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:~/compiler/lib
ls ~
ls ~/gamemodes
ls ~/gamemodes/modules
~/compiler/bin/pawncc -iinclude -D~/gamemodes -d3 "-;+" "-(+" $@
