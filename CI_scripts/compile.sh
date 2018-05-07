#!/bin/bash

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:~/compiler/lib
echo "KROPKA:"
ls .
echo "HOME:"
ls ~
~/compiler/bin/pawncc -iinclude -d3 "-;+" "-(+" ~/gamemodes/Mrucznik-RP.pwn
