#!/bin/bash -xe

terraform workspace select ${BRANCH_NAME}
terraform init -upgrade
terraform validate
terraform plan -destroy -var-file=${BRANCH_NAME}.tfvars
terraform destroy -auto-approve -var-file=${BRANCH_NAME}.tfvars