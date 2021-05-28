# Encrypted Remote State Bucket

## Usage

```hcl
module "terraform_remote_state_bucket" {
    source = "../modules/terraform_remote_state_bucket"
    bucket_name = "tf-remote-state-${local.stage_name}"
    region = local.tenant_name
}
```
