


module "s3" {
  source = "./modules/s3"
    region = var.region
    environment = var.environment
    cloudfront_distribution_arn = module.cloudfront.distribution_arn

}

module "cloudfront" {
  source = "./modules/cloudfront"
  environment = var.environment
  s3_bucket_regional_domain_name = module.s3.bucket_regional_domain_name
  s3_origin_id = module.s3.bucket_id
}