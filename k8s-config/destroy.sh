#!/bin/bash -xe

terraform init -upgrade
terraform workspace select ${BRANCH_NAME}
terraform plan -destroy -var-file=${BRANCH_NAME}.tfvars
terraform destroy -var-file=${BRANCH_NAME}.tfvars -auto-approve