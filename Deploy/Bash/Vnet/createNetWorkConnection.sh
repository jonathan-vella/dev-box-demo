#!/bin/bash

# Script to deploy an ARM Template for Network Connection using Azure CLI.

# Check if the correct number of arguments is provided.
if [ "$#" -ne 5 ]; then
    echo "Error: Incorrect number of arguments."
    echo "Usage: $0 <location> <subscriptionId> <resourceGroupName> <vnetName> <subNetName>"
    exit 1
fi

# Assign command-line arguments to variables with descriptive names.
location=$1
subscriptionId=$2
resourceGroupName=$3
vnetName=$4
subNetName=$5

# Specify the URL for the ARM Template and the file path to store the template.
templateUrl='https://github.com/Evilazaro/MicrosoftDevBox/blob/main/Deploy/ARMTemplates/Network-Connection-Template.json' 
outputFilePath='./DownloadedFiles/Network-Connection-Template-Output.json'

# (Optional) You can add a step to download the ARM template from the URL to the specified file path.
# wget $templateUrl -O $outputFilePath

# Provide feedback to the user about the deployment initiation.
echo "Initiating deployment using the ARM Template..."

# Deploy the ARM Template using the Azure CLI.
az deployment group create \
    --name Network-Connection-Template \
    --template-file $outputFilePath \
    --parameters \
        '<location>'=$location \
        '<subscriptionId>'=$subscriptionId \
        '<resourceGroupName>'=$resourceGroupName \
        '<vnetName>'=$vnetName \
        '<subNetName>'=$subNetName

# Check the exit status of the last command to determine if the deployment was successful.
if [ $? -eq 0 ]; then
    echo "Deployment was successful!"
else
    echo "Deployment failed. Please check the provided parameters and try again."
fi
