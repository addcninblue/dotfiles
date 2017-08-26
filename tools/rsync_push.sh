#!/bin/bash

# author: Addison Chan
# copies folder to remote machine with identical structure via rsync
# usage command.sh "folder" "remote machine name"

if [[ -z $1 || -z $2 ]]; then
	echo 'usage command.sh "folder" "remote machine name"'
	exit
fi

folder=$1
machine=$2
path=$(pwd)
localpath="$path/$folder/"
remotepath="$path/$folder"
execute="rsync -a $localpath $machine:$remotepath"

eval $execute
