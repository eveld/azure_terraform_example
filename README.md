```
# Sign in to azure and set subscription.
az login
az account list
az account set --subscription="..."

# Initialize terraform
terraform init

# See which changes will be applied.
terraform plan

# Apply the changes.
terraform apply
```