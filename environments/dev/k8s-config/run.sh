#!/bin/bash -xe

terraform workspace new ${BRANCH_NAME}
terraform init -upgrade
terraform validate
terraform plan -var-file=${BRANCH_NAME}.tfvars
terraform apply -auto-approve -var-file=${BRANCH_NAME}.tfvars