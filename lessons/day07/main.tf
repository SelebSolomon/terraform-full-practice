
# variable for environment


# local variable for bucket name

# Create a S3 bucket
# resource "aws_s3_bucket" "tf_test_bucket" {
#   bucket = local.bucket_name

#   tags = {
#     Name        = "My bucket"
#     Environment = var.environment
#   }
# }

resource "aws_instance" "example" {
  count = var.instance_count
  ami           = "resolve:ssm:/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
  instance_type = tolist(var.allowed_vm_types)[0]
  monitoring = var.config.monitoring
  associate_public_ip_address = var.associate_public_id
  tags = var.ec2_tags
}

resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic and all outbound traffic"

  tags = {
    Name = "allow_tls"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = var.cidr_block[0]
  from_port         = var.ingress_values[0]
  ip_protocol       = var.ingress_values[1]
  to_port           = var.ingress_values[2]
}



resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

