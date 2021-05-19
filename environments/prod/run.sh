export GOOGLE_APPLICATION_CREDENTIALS="./pol-pod11-dev-01.json"
terraform init
terraform validate
terraform plan
terraform apply -auto-approve