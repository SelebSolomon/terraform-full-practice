resource "aws_instance" "example" {
  ami           = "resolve:ssm:/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
  count = var.instance_count
  instance_type = var.environment == "prod" ? "t3.micro" : "t3.small"

  tags = {
    Name = "HelloWorld"
  }
}

resource "aws_security_group" "example" {
  name   = "sg"

  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      from_port = ingress.value.from_port
      to_port = ingress.value.to_port
      protocol = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
      description = ingress.value.description
    }   
  }
  egress  = []
}

locals {
  instance_id = aws_instance.example[*].id
}

output "instances" {
  value = local.instance_id
}