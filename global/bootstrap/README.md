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
Create workspace for every working branch.
```
terraform workspace new BRANCH_NAME

terraform workspace new dev
terraform workspace new dev-secondary
terraform workspace new prod
```

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
                       cloudresourcemanager.googleapis.com \
                       cloudscheduler.googleapis.com \
                       sqladmin.googleapis.com \
                       servicenetworking.googleapis.com \
                       secretmanager.googleapis.com \
                       containeranalysis.googleapis.com \
                       artifactregistry.googleapis.com \
                       iam.googleapis.com \
                       anthos.googleapis.com \
                       cloudtrace.googleapis.com \
                       meshca.googleapis.com \
                       meshtelemetry.googleapis.com \
                       meshconfig.googleapis.com \
                       iamcredentials.googleapis.com \
                       gkeconnect.googleapis.com \
                       gkehub.googleapis.com \
                       monitoring.googleapis.com \
                       logging.googleapis.com \
                       multiclusteringress.googleapis.com
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

## Build Scheduler

To schedule a cloud build:<br>
A Cloud Build trigger automatically starts a build morning at 7:45 from monday to friday to creates environment and destroy it after finished job evening at 20:00.

Create trigger
```hcl
    gcloud beta builds triggers create github \
    --repo-name= REPO_NAME \
    --repo-owner= REPO_OWNER \
    --branch-pattern= BRANCH_PATTERN \ # or --tag-pattern=TAG_PATTERN
    --build-config= BUILD_CONFIG_FILE \
```
| Name | Description |
|------|-------------|
|REPO_NAME|Name of your repository|
|REPO_OWNER|Username of the repository owney|
|BRANCH_PATTERN|Branch name in your repository to invoke the build on|
|TAG_PATTERN|Tag name in your repository to invoke the build on|
|BUILD_CONFIG_FILE|Path to your build configuration file|

Create trigger for build environment
```hcl
    gcloud beta builds triggers create github \
    --repo-name= pod11-infra \
    --repo-owner= snoogft \
    --branch-pattern= dev
    --build-config= cloudbuild.yaml \
```
Create trigger for destroy environment
```hcl
    gcloud beta builds triggers create github \
    --repo-name= pod11-infra \
    --repo-owner= snoogft \
    --branch-pattern= dev
    --build-config= clouddestroy.yaml \
```

Create scheduler 
```hcl
    gcloud scheduler jobs create http ${PROJECT_ID}-run-trigger \
    --schedule= CRON \
    --uri=https://cloudbuild.googleapis.com/v1/projects/${PROJECT_ID}/triggers/TRIGGER_ID:run \ 
    --message-body='{\"branchName\": \"BRANCH_NAME\"}' \
    --oauth-service-account-email=${PROJECT_ID}@appspot.gserviceaccount.com \
    --oauth-token-scope=https://www.googleapis.com/auth/cloud-platform
```
| Name | Description |
|------|-------------|
|CRON|Cron expression, example: https://crontab.guru/|
|TRIGGER_ID|Trigger ID from trigger created ealier|

Create scheduler for trigger to run build environment
```hcl
    gcloud scheduler jobs create http ${PROJECT_ID}-run-trigger \
    --schedule= 45 7 * * 1-5 \
    --uri=https://cloudbuild.googleapis.com/v1/projects/${PROJECT_ID}/triggers/TRIGGER_ID:run \ 
    --message-body='{\"branchName\": \"BRANCH_NAME\"}' \
    --oauth-service-account-email=${PROJECT_ID}@appspot.gserviceaccount.com \
    --oauth-token-scope=https://www.googleapis.com/auth/cloud-platform
```

Create scheduler for trigger to run destroy environment
```hcl
    gcloud scheduler jobs create http ${PROJECT_ID}-run-trigger \
    --schedule= 0 20 * * 1-5 \
    --uri=https://cloudbuild.googleapis.com/v1/projects/${PROJECT_ID}/triggers/TRIGGER_ID:run \ 
    --message-body='{\"branchName\": \"BRANCH_NAME\"}' \
    --oauth-service-account-email=${PROJECT_ID}@appspot.gserviceaccount.com \
    --oauth-token-scope=https://www.googleapis.com/auth/cloud-platform
```
