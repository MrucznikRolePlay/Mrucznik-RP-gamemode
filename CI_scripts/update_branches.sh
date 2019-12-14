#!/bin/bash

git checkout master
git pull

for branch_name in development creative hotfixy mrucznik Sandal
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
