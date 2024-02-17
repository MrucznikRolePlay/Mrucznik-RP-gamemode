
#!/bin/bash
cd dependencies
rm -rf amx_assembly
git clone git@github.com:MrucznikRolePlay/amx_assembly
cd amx_assembly
git checkout v4.69
cd ../
rm -rf indirection
git clone git@github.com:MrucznikRolePlay/indirection
cd ../
