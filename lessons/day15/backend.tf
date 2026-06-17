terraform {
      backend "s3" {
    bucket = "terraform-lockfiles-8276377282"
    key    = "dev/terraform.tfstate"
    region = "eu-north-1"
    use_lockfile = true
    encrypt = true
  }
}