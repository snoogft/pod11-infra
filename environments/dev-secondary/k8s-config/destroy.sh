#!/bin/bash -xe

terraform init -upgrade
terraform validate
terraform plan -destroy
terraform destroy -auto-approve