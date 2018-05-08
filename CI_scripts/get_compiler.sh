#!/bin/bash

echo "Getting lastest zeex PAWN compiler"
mkdir ~/compiler
cd ~/compiler
wget -q https://github.com/$(wget -q https://github.com/pawn-lang/compiler/releases/latest -O - | egrep '/.*/.*/.*-linux.tar.gz' -o)
tar -xf * --strip=1
