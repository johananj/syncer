#!/bin/bash

arguments=" Arguments: \n
ARG1 -- function to perform [dryrun/copy/copy-delete] \n
ARG2 -- folder name \n
ARG3 -- source device \n
ARG4 -- target device \n"

# test arguments
if [[ " $@ " =~ " -h " ]]; then
  echo -e $arguments
  echo "-l list locations"
  echo "-n list folder names"
  exit
elif [[ " $@ " =~ " -l " ]]; then
  head -1 locations.csv | sed 's/, /\n/g' | tail -n +2
  exit
elif [[ " $@ " =~ " -n " ]]; then
  cut -d "," -f1 locations.csv | tail -n +2
  exit
elif [[ $# -lt 4 ]]; then
  echo "ERROR: Not enough arguments. Use -h for help."
  exit
fi

focus_line=`head -$(cat locations.csv | cut -d "," -f1 | grep -nw $2 | cut -d ":" -f1) locations.csv | tail -1`
source_dev_num=`head -1 locations.csv | sed 's/, /\n/g' | grep -nw $3 | cut -d ":" -f1`
target_dev_num=`head -1 locations.csv | sed 's/, /\n/g' | grep -nw $4 | cut -d ":" -f1`
source_folder=`echo $focus_line | cut -d "," -f$source_dev_num`
target_folder=`echo $focus_line | cut -d "," -f$target_dev_num`


# test folders
if [[ $target_folder == '' ]]; then
  echo "ERROR: You have not specified a target folder for this operation in locations.csv"
  exit
fi


# sync
if [[ $1 == 'dryrun' ]]; then
  echo "[DRYRUN] Copying from $source_folder to $target_folder"
  rsync -avh --dry-run $source_folder $target_folder
  echo "=========="
elif [[ $1 == 'copy' ]]; then
  echo "You are about to copy. Are you sure [y/n]"
  read -n 1 response
  echo ""
  if [[ $response == "y" ]]; then
    echo "Copying from $source_folder to $target_folder"
    rsync -avh $source_folder $target_folder
    echo "=========="
  fi
elif [[ $1 == 'copy-delete' ]]; then
  echo "You are about to DELETE FILES in target that are not in source. Are you sure [y/n]"
  read -n 1 response
  echo ""
  if [[ $response == "y" ]]; then
    echo "Copying from $source_folder to $target_folder"
    rsync -avh --delete $source_folder $target_folder
    echo "=========="
  fi
fi
