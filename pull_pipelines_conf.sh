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
destination_folder=./pipelines
#
echo "This script make a dump of all pipelines available in Spinnaker and dump them to a folder, must be run in bastion host"
echo "Getting all applications available in Spinnaker"
spin -k application list|jq -c '.[] | .["name"]'|sed s/\"//g 2>/dev/null > ./applications.tmp

echo "Querying all pipeline for each application, this could take some time"

for application in $(cat ./applications.tmp); do
   echo "Creating directory for $application"
   mkdir -p $destination_folder/$application
   cd $destination_folder/$application
   echo "Querying pipelines availables in $application"
   for pipeline in $(spin -k pipeline list --application $application | jq -r '.[] | @base64'); do
        echo ${pipeline}|base64 --decode | jq '.' > ./$(echo ${pipeline}|base64 --decode | jq -r '.name').yml
   done
   cd ../..

done
# Deleting tmp files
rm ./applications.tmp

echo "To restore any application just run example -> spin -k pipeline save --file application1/test-dev.yml"