#!/bin/bash

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:~/compiler/lib
echo "KROPKA:"
ls .
echo "HOME:"
ls ~
cd gamemodes
~/compiler/bin/pawncc -i../include -d3 "-;+" "-(+" Mrucznik-RP.pwn
