#!/bin/bash

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:~/compiler/lib
ls ~
ls *
ls */*
~/compiler/bin/pawncc -iinclude -d3 "-;+" "-(+" $@
