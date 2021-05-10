# Stage 1 - Terraform code for deploying GCS Bucket and activating required APIs

## Purpose

The purpose of this module is to create a GCS bucket for storing Terraform state. 

From the book `Terraform Up & Running`:
> Terraform’s backends have a few limitations and gotchas that you need
> to be aware of. The first limitation is the chicken-and-egg situation of
> using Terraform to create the S3 bucket where you want to store your
> Terraform state. To make this work, you had to use a two-step process: 
> 1. Write Terraform code to create the S3 bucket and DynamoDB
> table and deploy that code with a local backend.
> 2. Go back to the Terraform code, add a remote backend
> configuration to it to use the newly created S3 bucket and
> DynamoDB table, and run terraform init to copy your
> local state to S3.

Additionally this module have to enable all required APIs in order to create infrastructure.

## Usage
Enable APIs
```
gcloud services enable compute.googleapis.com \
cloudbuild.googleapis.com \
container.googleapis.com \
containerregistry.googleapis.com \
secretmanager.googleapis.com \
storage-api.googleapis.com \
oslogin.googleapis.com \
iap.googleapis.com \
cloudresourcemanager.googleapis.com
```

In order to use this module you have to copy example file:
```bash
cp terraform.tfvars.example terraform.tfvars
```

1. Go to [IAM & Admin](https://console.cloud.google.com/iam-admin) and create a service account for Terraform
2. Grant it a `Storage Object Creator` role
3. Generate and download JSON file with credentials for accessing terraform service account

Edit the `terraform.tfvars` and put correct variables.

Initialize terraform
```bash
terraform init
```
Run `terraform plan` and `terraform apply`
```bash
terraform plan
```

```bash
terraform apply
```

Remember to migrate a local state to the newly configured "gcs" remote backend. In order to do that uncomment following code in `backend.tf` and put proper values in `bucket`, `prefix` and `credentials`.

```hcl
#terraform {
#  backend "gcs" {
#    bucket  = "project-306607-tfstate"
#    prefix  = "global"
#    credentials = "project-306607-0e52f545c1d0.json"
#  }
#}
```

Run `terraform init`

## Inputs
| Name | Description | Type |
|------|-------------|------|
|credentials|Path to a file containing credentials to GCP Service account with enough permissions to create GCS bucket|string|
|iam_member|IAM member to grant permissions on the bucket|string|
|project_id|The ID of the project in which to provision resources.|string|

## Outputs

| Name | Description |
|------|-------------|
|bucket|The created storage bucket|

## Requirements

These sections describe requirements for using this module.

- Terraform v0.14
