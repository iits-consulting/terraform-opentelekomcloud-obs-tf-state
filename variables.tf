variable "bucket_name" {
  description = "The bucket name where the encrypted tf file should be stored"
}
variable "force_encryption" {
  default     = true
  description = "Add an encryption enforcing policy to the state bucket. Default = true"
}
variable "region" {}
