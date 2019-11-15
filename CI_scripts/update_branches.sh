#!/bin/bash

git checkout master
git pull

for branch_name in development creative hotfixy simeone 2.6.2 mrucznik
do
    git checkout $branch_name
    if ! git merge master
    then 
        git merge --abort
    else
        git push
    fi 
done

git checkout master
