terraform {
  backend "s3" {
    acl                  = "bucket-owner-full-control"
    bucket               = "timoteo-test-terraform"
    encrypt              = true
    key                  = "tsoutello-eks"
    region               = "sa-east-1"
    workspace_key_prefix = "tsoutello-eks"
  }
}
