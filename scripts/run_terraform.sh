#!/usr/bin/env bash
set -e
BRANCH_NAME=$1
if [ -d "environments/$BRANCH_NAME/" ]; then
  cd environments/$BRANCH_NAME
  terraform init
else
  for dir in environments/*/
  do
    cd ${dir}
    env=${dir%*/}
    env=${env#*/}
    echo ""
    echo "*************** TERRAFORM INIT ******************"
    echo "******* At environment: ${env} ********"
    echo "*************************************************"
    terraform init || exit 1
    cd ../../
  done
fi
if [ -d "environments/$BRANCH_NAME/" ]; then
  cd environments/$BRANCH_NAME
  terraform plan
else
  for dir in environments/*/
  do
    cd ${dir}
    env=${dir%*/}
    env=${env#*/}
    echo ""
    echo "*************** TERRAFOM PLAN ******************"
    echo "******* At environment: ${env} ********"
    echo "*************************************************"
    terraform plan || exit 1
    cd ../../
  done
fi
if [ -d "environments/$BRANCH_NAME/" ]; then
  cd environments/$BRANCH_NAME
  terraform apply -auto-approve
else
  echo "********************** SKIPPING APPLYING ************************"
  echo "Branch '$BRANCH_NAME' does not represent an official environment."
  echo "*****************************************************************"
fi
