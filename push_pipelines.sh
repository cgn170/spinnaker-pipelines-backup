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
origin_folder=./pipelines
#
echo "This script update all pipelines available in a folder to Spinnaker, must be run in bastion host"
echo "Getting all pipelines configuration available in $origin_folder"

for application_folder in $(ls -1 $origin_folder); do
   echo "Applying changes in application $application_folder"
   cd $origin_folder/$application_folder
   for pipeline_file in $(ls -1); do
        echo "Updating $pipeline_file"
        spin -k pipeline save --file $pipeline_file
   done
   cd ../..
done
cd ..

echo "Done!"
