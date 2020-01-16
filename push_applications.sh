#!/usr/bin/env bash

###### Main Code

dependencies(){
    # Checking dependencies
    echo "Checking dependencies, spin and jq"
    # Checking SPIN
    if command -v jq >/dev/null 2>&1 ; then
        echo "sping found"
        echo "version: $(spin --version)"
    else
        echo "sping not found, exiting ..."
    fi
    # Chechking JQ
    if command -v jq >/dev/null 2>&1 ; then
        echo "jq found"
        echo "version: $(jq --version)"
    else
        echo "jq not found, exiting ..."
    fi
}

dependencies
origin_folder=./applications
#
echo "This script update all applications available in a folder to Spinnaker"
cd $origin_folder

for application in $(ls -1 $origin_folder); do
    echo "Updating $application"
    spin -k application save --file $application
done

cd ..

echo "Done!"