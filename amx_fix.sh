#!/bin/bash
cd dependencies
rm -rf amx_assembly
git clone git@github.com:MrucznikRolePlay/amx_assembly
cd amx_assembly
git checkout v4.69
cd ../..

sed -i 's/MAX_CA_OBJECTS > 50000/MAX_CA_OBJECTS > 100000/g' ./dependencies/ColAndreas/Server/include/colandreas.inc