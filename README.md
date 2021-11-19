# Encrypted Remote State Bucket

[![Apache-2.0 License](https://img.shields.io/badge/License-Apache%202.0-blue.svg?)](https://github.com/iits-consulting/terraform-opentelekomcloud-obs-tf-state/blob/master/LICENSE)
![Terraform Lint](https://github.com/iits-consulting/terraform-opentelekomcloud-obs-tf-state/workflows/terraform-lint/badge.svg)
![ViewCount](https://views.whatilearened.today/views/github/iits-consulting/terraform-opentelekomcloud-obs-tf-state.svg)


Creates an encrypted OBS Bucket for your terraform remote state.

After the creation it prints out the right backend s3 terraform settings which you can copy
and paste into your settings.tf

## Usage

Set your AK/SK and source such a bash file 

```bash
export STAGE_NAME=presentation
export ACCESS_KEY="REPLACE_ME" 
export SECRET_KEY="REPLACE_ME" 
export AWS_SECRET_ACCESS_KEY=$SECRET_KEY 
export AWS_ACCESS_KEY_ID=$ACCESS_KEY 
export OS_ACCESS_KEY=$ACCESS_KEY 
export OS_SECRET_KEY=$SECRET_KEY
```

create a folder tf-remote-state-bucket and a main.tf with this content:

```hcl

terraform {
  required_version = "v0.14.8"
  required_providers {
    opentelekomcloud = {
      source  = "opentelekomcloud/opentelekomcloud"
      version = "1.23.12"
    }
  }
}

locals {
  tenant_name = "eu-de"
  otc_domain_name="OTC-EU-DE-0000XXXXXXXXXXX"
  stage_name="presentation"
}

provider "opentelekomcloud" {
  auth_url    = "https://iam.eu-de.otc.t-systems.com/v3"
  domain_name = local.otc_domain_name
  tenant_name = local.tenant_name
}

module "terraform_remote_state_bucket" {
  source  = "iits-consulting/obs-tf-state/opentelekomcloud"
  version = "1.0.1"
  bucket_name = "tf-remote-state-${local.stage_name}"
  region = local.tenant_name
}

output "backend_config" {
  value = module.terraform_remote_state_bucket.backend_config
}
```

## Example Output:
```hcl
backend "s3" {
  key = "tfstate"
  bucket = "tf-remote-state-presentation"
  region = "eu-de"
  endpoint = "obs.eu-de.otc.t-systems.com"
  skip_region_validation = true
  skip_credentials_validation = true
  encrypt = true
  kms_key_id = "arn:aws:kms:eu-de:d32336fe26ec415caa04e1731adfb6a8:key/288fb46c-5245-4238-aa05-6e92385bca33"
}
```