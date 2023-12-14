## Usage
To provision resources using Terraform, navigate to the project root directory and run the following command:

```sh
terraform init
```

```
curl -s --location --request GET 'https://napi.arvancloud.ir/ecc/v1/regions/ir-tbz-dc1/sizes' \
--header 'Accept: application/json' \
--header 'Authorization: apikey <TODO: FILL HERE>' | jq .data[].id
```

```sh
terraform plan
terraform apply
```

To destroy the resources created by Terraform, run:
```sh
terraform destroy
```

```sh
terraform fmt
terraform fmt --recursive
terraform validate
terraform state list
```
