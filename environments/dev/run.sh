#!/bin/bash -xe

terraform init -upgrade
terraform validate
terraform plan -var-file=${BRANCH_NAME}.tfvars
terraform apply -auto-approve -var-file=${BRANCH_NAME}.tfvars