#!/bin/bash -xe

terraform init -upgrade
terraform validate
terraform plan
terraform apply -auto-approve