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
destination_folder=./applications
#
echo "This script make a dump of all applications available in Spinnaker and dump them to a folder, must be run in bastion host"
echo "Getting all applications available in Spinnaker"
spin -k application list|jq -c '.[] | .["name"]'|sed s/\"//g 2>/dev/null > ./applications.tmp
mkdir -p $destination_folder
echo "Querying all applications, this could take some time"
for application in $(cat ./applications.tmp); do
   echo "Querying $application"
   spin -k application get ${application} > $destination_folder/${application}.yml
done
# Deleting tmp files
rm ./applications.tmp

echo "To restore any application just run example -> spin -k application save --file spin-test.yml"