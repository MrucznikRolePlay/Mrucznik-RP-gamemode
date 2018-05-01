#!/bin/bash

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:~/compiler/lib
~/compiler/bin/pawncc -iinclude -d2 -;+ -(+ $@
