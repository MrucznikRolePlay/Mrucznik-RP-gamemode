#!/bin/bash

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:~/compiler/lib
ls ~
ls *
ls */*
~/compiler/bin/pawncc -iinclude -D_LINUX -D~/gamemodes -d3 "-;+" "-(+" $@
