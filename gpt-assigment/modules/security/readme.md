# 📦 Project 3 — Security Groups (Terraform)

## 📌 Module Name
modules/security

---

## 🎯 Purpose
This project focuses on **controlling network traffic** inside an AWS VPC using **Security Groups**.

Security Groups act as **virtual firewalls** that decide:
- What traffic is allowed **into** a resource (ingress)
- What traffic is allowed **out** of a resource (egress)

---

## 🧱 Resources Used

- aws_security_group (web)
- aws_security_group (ssh)

---

## 🔐 What Is a Security Group?
A Security Group is a **stateful firewall** attached to AWS resources such as EC2 instances.

Key characteristics:
- Works at the **instance level**
- Stateful (responses are automatically allowed)
- Rules are **allow-only** (no deny rules)
- Lives inside a **VPC**

---

## 🧩 Security Groups Created

### 1️⃣ Web Security Group (`web`)
Purpose: Allow web traffic to reach application servers.

Ingress rules:
- HTTP → Port 80 → Open to internet
- HTTPS → Port 443 → Open to internet

Egress rules:
- Allow all outbound traffic

Why:
- Web applications must be reachable by users from anywhere.

---

### 2️⃣ SSH Security Group (`ssh`)
Purpose: Allow administrators to securely access servers.

Ingress rules:
- SSH → Port 22 → Used for server login

Egress rules:
- Allow all outbound traffic

Why:
- SSH is used to configure, manage, and troubleshoot servers.

⚠️ Note:
In real production systems, SSH access should be **restricted to specific IPs**, not `0.0.0.0/0`.

---

## 🌍 Understanding `0.0.0.0/0`

`0.0.0.0/0` means:
- “Allow traffic from anywhere on the internet”

Used when:
- You want public access (e.g. websites)

Avoid when:
- Protecting admin services like SSH

---

## 🖥️ What Is SSH?
SSH (Secure Shell) is a secure way to:
- Log into remote servers
- Run commands
- Manage cloud infrastructure

Without SSH:
- You cannot directly access an EC2 instance terminal.

---

## 🧠 Best Practices Learned

- Separate security groups by responsibility (web vs admin)
- Never expose SSH publicly in production
- Only open ports that are absolutely required
- Security Groups are reusable across resources
- Security Groups must be attached to resources to be effective

---

## 🔗 How This Connects to Other Projects

- VPC → Security Groups live inside a VPC
- Subnets → Instances inside subnets use Security Groups
- EC2 → Security Groups protect EC2 instances
- Load Balancers → Also use Security Groups

---

## 🧩 Mental Model

> If traffic is not allowed in the Security Group,  
> it never reaches the server — no matter what.

---

## ✅ Outcome
After this project, I understand:
- How to design firewall rules in AWS
- The difference between web access and admin access
- How Security Groups control traffic flow
- How to structure Security Groups using Terraform modules

---

## ⏭️ Next Project
📦 Project 4 — EC2 (Compute)

I will attach these security groups to EC2 instances and test real connectivity.

---