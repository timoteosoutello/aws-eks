terraform {
  backend "s3" {
    acl                  = "bucket-owner-full-control"
    bucket               = "terraform-state"
    encrypt              = true
    key                  = "tsoutello-eks"
    region               = var.region
    workspace_key_prefix = "tsoutello-eks"
  }
}
