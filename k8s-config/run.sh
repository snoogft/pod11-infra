#!/bin/bash -xe

terraform init -upgrade
terraform workspace new ${BRANCH_NAME}
terraform workspace select ${BRANCH_NAME}
terraform plan -var-file=${BRANCH_NAME}.tfvars
terraform apply -var-file=${BRANCH_NAME}.tfvars -auto-approve