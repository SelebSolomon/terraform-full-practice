
module "vpc" {
  source = "./modules/vpc"
 private_subnets = var.private_subnets
 public_subnets = var.public_subnets
 azs = var.azs

}


module "security" {
  source = "./modules/security"

  vpc_id = module.vpc.vpc_id
  environment = var.environment
}

module "instance" {
  source = "./modules/instances"

  security_group_ids = module.security.security_groups_ids
  public_subnet_id = module.vpc.public_subnet_ids
  private_subnet_id = module.vpc.private_subnet_ids
  
}

module "alb" {
  source = "./modules/alb"
  public_subnets = module.vpc.public_subnet_ids
  instance_private = module.instance.private_instances
  vpc_id = module.vpc.vpc_id
}