# 📦 TERRAFORM EC2 PROJECT — FULL DOCUMENTATION

# 🧠 OVERVIEW
This project demonstrates how to build AWS infrastructure using Terraform with EC2, VPC networking, security groups, subnets, NAT, and modular architecture.

It focuses on:
- EC2 deployment (public + private)
- VPC networking design
- Security group isolation
- Multi-instance deployment using for_each
- Modular Terraform structure

---

# 🏗️ ARCHITECTURE

VPC (Main Network)
├── Public Subnets
│     └── Public EC2 Instances (internet access)
│
├── Private Subnets
│     └── Private EC2 Instances (no direct internet access)
│
├── Internet Gateway (IGW)
│     └── Enables internet access for public subnet
│
├── NAT Gateway
│     └── Allows private EC2 outbound internet access
│
└── Route Tables
      ├── Public Route Table → IGW
      └── Private Route Table → NAT Gateway

Security Groups
├── Web SG → HTTP/HTTPS access
└── SSH SG → restricted SSH access

---

# 📦 MODULE STRUCTURE

modules/
├── vpc/
├── security/
└── instances/

---

# ⚙️ AWS RESOURCES USED

Networking:
- aws_vpc
- aws_subnet
- aws_internet_gateway
- aws_nat_gateway
- aws_route_table
- aws_route_table_association

Compute:
- aws_instance
- aws_key_pair

Security:
- aws_security_group

Terraform Features:
- module
- for_each
- variables
- outputs

---

# 🖥️ EC2 IMPLEMENTATION

# Public EC2
resource "aws_instance" "public_ec2" {
  ami                    = "ami-0aba19e56f3eaec05"
  instance_type          = "t3.micro"
  key_name              = aws_key_pair.deployer.key_name
  subnet_id             = each.value
  vpc_security_group_ids = var.security_group_ids

  tags = {
    Name = "public-${var.instance_name}"
  }
}

✔ Runs in public subnet  
✔ Has internet access  
✔ Used for web apps or bastion host  

---

# Private EC2
resource "aws_instance" "ec2_private" {
  ami                    = "ami-0aba19e56f3eaec05"
  instance_type          = "t3.micro"
  key_name              = aws_key_pair.deployer.key_name
  subnet_id             = each.value
  vpc_security_group_ids = var.security_group_ids

  tags = {
    Name = "private-${var.instance_name}"
  }
}

✔ Runs in private subnet  
✔ No public IP  
✔ Outbound internet via NAT Gateway  
✔ Used for backend services  

---

# 🔐 SECURITY GROUPS

# Web Security Group
- HTTP (80) → open to internet
- HTTPS (443) → open to internet

# SSH Security Group
- SSH (22) → restricted (VPC or bastion)
- No direct public access for private EC2

---

# 🔑 KEY PAIR

resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = "ssh-rsa ...."
}

✔ Used for SSH login into EC2  
✔ Private key stays on local machine  

---

# 🌐 NETWORKING FLOW

Internet → IGW → Public Subnet → Public EC2  
Private EC2 → NAT Gateway → Internet (outbound only)

---

# 🔁 FOR_EACH USAGE

Used to create multiple EC2 instances:

for_each = toset(var.public_subnet_id)

✔ One EC2 per subnet  
✔ Dynamic scaling of infrastructure  

---

# 🔗 MODULE CONNECTION FLOW

VPC Module → outputs subnet IDs  
Security Module → outputs SG IDs  
Instance Module → consumes both → creates EC2  

---

# ⚠️ COMMON MISTAKES FIXED

- Wrong CIDR blocks for subnets
- Mixing public/private security groups
- Using string instead of list in for_each
- Attaching wrong subnet type
- Not separating modules properly
- Confusing IGW vs NAT Gateway

---

# 🧠 KEY LEARNINGS

✔ EC2 depends on networking (VPC + Subnets)  
✔ Security Groups control traffic flow  
✔ Public vs private subnet defines exposure  
✔ NAT enables private outbound internet  
✔ Terraform modules improve structure  
✔ Infrastructure must be designed, not just created  

---

# 🚀 FINAL UNDERSTANDING

AWS infrastructure is not just about creating resources — it is about properly connecting them.

Terraform makes this connection declarative and repeatable.

---

# 📌 NEXT STEP

PROJECT 6 → Application Load Balancer (ALB)