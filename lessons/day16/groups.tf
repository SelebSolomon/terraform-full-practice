
resource "aws_iam_group" "education" {
  name = "Education"
  path = "/groups/"

}


resource "aws_iam_group" "managers" {
  name = "Managers"
  path = "/groups/"
  
}


resource "aws_iam_group" "engineers" {
  name = "Enginners"
  path = "/groups/"
  
}



resource "aws_iam_group_membership" "education_members" {
  name = "education-group-memberships"
  
  group = aws_iam_group.education.name

  users = [
    for user in aws_iam_user.users :  user.name if user.tags.Department == "Education"
  ]
}


resource "aws_iam_group_membership" "engineers_members" {
  name = "engineers-group-memberships"
  
  group = aws_iam_group.engineers.name

  users = [
    for user in aws_iam_user.users :  user.name if user.tags.Department == "Education"
  ]
}


resource "aws_iam_group_membership" "managers_members" {
  name = "managers-group-memberships"
  
  group = aws_iam_group.managers.name

  users = [
    for user in aws_iam_user.users :  user.name if contains(keys(user.tags), "Jobtitle") && can(regex("Manager|CEO", user.tags.JobTitle ))
  ]
}


# resource "aws_iam_group_policy" "my_developer_policy" {
#   name  = "my_education_policy"
#   group = aws_iam_group.education.name

#   # Terraform's "jsonencode" function converts a
#   # Terraform expression result to valid JSON syntax.
#   policy = jsonencode({
#     Statement = [
#       {
#         Action = [
#           "ec2:Describe*",
#         ]
#         Effect   = "Allow"
#         Resource = "*"
#       },
#     ]
#   })
# }
