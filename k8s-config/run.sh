#!/bin/bash -xe

TF_VAR_cluster_name=$1 #first argument in call for run.sh in cloudbuild-dev.yaml
TF_VAR_zone=$2 #second argument in call for run.sh in cloudbuild-dev.yaml

terraform init -upgrade
terraform workspace select ${BRANCH_NAME}
terraform plan -var-file=${BRANCH_NAME}.tfvars
terraform apply -var-file=${BRANCH_NAME}.tfvars -auto-approve
