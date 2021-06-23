#!/bin/bash -xe

export TF_VAR_cluster_name=$1 #first argument in call for run.sh in cloudbuild-dev.yaml
export TF_VAR_zone=$2 #second argument in call for run.sh in cloudbuild-dev.yaml

terraform init -upgrade
terraform workspace select ${TF_VAR_cluster_name}
terraform plan -destroy -var-file=${BRANCH_NAME}.tfvars
terraform destroy -var-file=${BRANCH_NAME}.tfvars -auto-approve