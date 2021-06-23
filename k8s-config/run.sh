#!/bin/bash -xe

terraform init -upgrade
terraform workspace select ${TF_VAR_cluster_name}
terraform plan -var-file=${BRANCH_NAME}.tfvars
terraform apply -var-file=${BRANCH_NAME}.tfvars -auto-approve
