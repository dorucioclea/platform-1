#!/bin/bash

##
# Standardised failure function
##
function error_and_die {
  echo -e "ERROR: ${1}" >&2;
  exit 1;
};

az login;

SUBSCRIPTION_ID=""

read -p "Enter subscription Id: "  SUBSCRIPTION_ID;

[ ! -z "$SUBSCRIPTION_ID" ] \
    || error_and_die "Required argument: Subscription Id";

az account set --subscription $SUBSCRIPTION_ID;

OUTPUT_FILE="service_principal"

[ ! -f OUTPUT_FILE ] \
    || error_and_die "Service principal already created!"

# Create the service principal
RESULT=$(az ad sp create-for-rbac --role 'Contributor');

# Not really sure echo is the best way here but it works
APP_ID=$(echo $RESULT | grep -m1 -oP '"appId"\s*:\s*"\K[^"]+');
TENANT=$(echo $RESULT | grep -m1 -oP '"tenant"\s*:\s*"\K[^"]+');
PASSWORD=$(echo $RESULT | grep -m1 -oP '"password"\s*:\s*"\K[^"]+');

echo "--subscription-id '$SUBSCRIPTION_ID'" >> $OUTPUT_FILE;
echo "--app-id '$APP_ID'" >> $OUTPUT_FILE;
echo "--password '$PASSWORD'" >> $OUTPUT_FILE;
echo "--tenant '$TENANT'" >> $OUTPUT_FILE;
echo "" >> $OUTPUT_FILE;
# Always clean up your service principal or leave yourself a way to do so
echo "# To delete the service principal" >> $OUTPUT_FILE;
echo "# az ad sp delete --id '$APP_ID' --subscription '$SUBSCRIPTION_ID'"  >> $OUTPUT_FILE;