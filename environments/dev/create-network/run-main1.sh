#!/bin/bash -xe

terraform init mainn1.tf -upgrade
terraform validate main1.tf
terraform plan main1.tf
terraform apply main1.tf -auto-approve