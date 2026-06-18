
module "vpc" {
  source = "./modules/vpc"

  subnet_one = var.subnet_one
  subnet_two = var.subnet_two
}