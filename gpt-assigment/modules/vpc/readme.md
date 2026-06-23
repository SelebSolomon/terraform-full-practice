# 📘 Terraform AWS VPC Project – Full Guide

## 🚀 Overview

This project demonstrates how to build a **real-world AWS network infrastructure using Terraform**.

It includes:
- VPC
- Public & Private Subnets (Multi-AZ)
- Internet Gateway (IGW)
- NAT Gateway
- Route Tables
- Route Table Associations
- Terraform Modules

---

# 🧠 Architecture Overview (How Everything Connects)

VPC is the main network boundary.
VPC
│
├── Public Subnets
│ ├── Connected to Internet Gateway (IGW)
│ └── Used for NAT Gateway + public resources
│
├── Private Subnets
│ ├── NO direct internet access
│ └── Routes outbound traffic via NAT Gateway
│
├── Internet Gateway (IGW)
│ └── Enables internet access for public subnets
│
└── NAT Gateway
└── Allows private subnets to access internet safely


---

# 🏗️ Step-by-Step Resource Breakdown

---

## 1. VPC (Main Network)

```hcl
resource "aws_vpc" "basic_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "vpc-practice"
  }
}

2. Public Subnets
resource "aws_subnet" "public_one" {
  vpc_id                  = aws_vpc.basic_vpc.id
  cidr_block              = var.public_one
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true
}
resource "aws_subnet" "public_two" {
  vpc_id                  = aws_vpc.basic_vpc.id
  cidr_block              = var.public_two
  availability_zone       = data.aws_availability_zones.available.names[1]
  map_public_ip_on_launch = true
}

👉 These subnets can access the internet directly.

3. Private Subnets
resource "aws_subnet" "private_one" {
  vpc_id            = aws_vpc.basic_vpc.id
  cidr_block        = var.private_one
  availability_zone = data.aws_availability_zones.available.names[0]
}
resource "aws_subnet" "private_two" {
  vpc_id            = aws_vpc.basic_vpc.id
  cidr_block        = var.private_two
  availability_zone = data.aws_availability_zones.available.names[1]
}

👉 These subnets are NOT exposed to the internet.

4. Internet Gateway (IGW)
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.basic_vpc.id
}

👉 This connects your VPC to the internet.

5. Public Route Table
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.basic_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

👉 Sends internet traffic to IGW.

6. Route Table Association (Public)
resource "aws_route_table_association" "public_one" {
  subnet_id      = aws_subnet.public_one.id
  route_table_id = aws_route_table.public_rt.id
}
resource "aws_route_table_association" "public_two" {
  subnet_id      = aws_subnet.public_two.id
  route_table_id = aws_route_table.public_rt.id
}
7. Elastic IP for NAT
resource "aws_eip" "nat" {
  domain = "vpc"
}

👉 Static public IP for NAT Gateway.

8. NAT Gateway
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public_one.id

  depends_on = [aws_internet_gateway.igw]
}

👉 Lets private subnets access the internet safely.

9. Private Route Table
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.basic_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }
}

👉 Sends private traffic through NAT Gateway.

10. Route Table Association (Private)
resource "aws_route_table_association" "private_one" {
  subnet_id      = aws_subnet.private_one.id
  route_table_id = aws_route_table.private_rt.id
}
resource "aws_route_table_association" "private_two" {
  subnet_id      = aws_subnet.private_two.id
  route_table_id = aws_route_table.private_rt.id
}

🧠 Key Concepts You Learned
Public Subnet
Has IGW route
Has public IP enabled
Internet accessible
Private Subnet
No direct internet access
Uses NAT Gateway for outbound traffic only
🔗 Full Flow Summary
Public Subnet → Internet Gateway → Internet

Private Subnet → NAT Gateway → Internet Gateway → Internet

⚠️ Important Rules
NAT Gateway MUST be in a public subnet
Private subnet NEVER connects directly to IGW
Each subnet must match correct CIDR block
Use AZ distribution for high availability

📦 Terraform Concepts Used
count → multiple resources
availability_zone → AZ mapping
map_public_ip_on_launch → public subnet behavior
depends_on → control resource creation order