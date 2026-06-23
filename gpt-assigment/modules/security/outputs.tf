
output "security_groups_ids" {
  value = [aws_security_group.ssh.id, aws_security_group.web.id, ]
}



output "private_sg" {
  value = aws_security_group.private_sg.id
}

