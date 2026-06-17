# resource "aws_s3_bucket" "example" {
#   count=2
#   bucket = var.bucket_names[count.index]

#   tags = var.s3_bucket_tags
  
# }


# resource "aws_s3_bucket" "example2" {
#   for_each= var.bucket_name_sets
#   bucket = each.key

#   tags = var.s3_bucket_tags
#   depends_on = [ aws_s3_bucket.example ] 
# }

resource "aws_instance" "example" {
  ami           = "ami-0ebc281c20e89ba4b"
  instance_type = tolist(var.allowed_vm_types)[0]
  region = var.region

  tags = {
    Name = "HelloWorld"
  }
  lifecycle {
    prevent_destroy = true
    create_before_destroy = true
  }
}


resource "aws_launch_template" "app_server" {
  name_prefix   = "app_server-"
  image_id      = "ami-0ebc281c20e89ba4b"
  instance_type = tolist(var.allowed_vm_types)[0]

  monitoring {
    enabled = var.config.monitoring
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "test"
    }
  }

}

resource "aws_autoscaling_group" "bar" {
  availability_zones = ["eu-north-1a", "eu-north-1b", "eu-north-1c"]
  desired_capacity   = 6
  max_size           = 4
  min_size           = 2
  health_check_type = "EC2"

  launch_template {
    id      = aws_launch_template.app_server.id
    version = "$Latest"
  }
}