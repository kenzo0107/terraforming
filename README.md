# terraforming

### Example
place `*.tfvars` file.  
In this case, I create `terraform_iam.tfvars` file.
```
"access_key" = "ACCESS_KEY"
"secret_key" = "SECRET_KEY"
```

execute following commands.
```sh
# check change like '--dry-run'
terraform plan -var-file=terraform_iam.tfvars
# apply change
terraform apply -var-file=terraform_iam.tfvars
```
