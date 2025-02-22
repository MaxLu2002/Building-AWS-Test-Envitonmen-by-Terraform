# create iam role
resource "aws_iam_role" "ec2_admin_role" {
  name = "${var.tags["name"]}-ec2-admin"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })
}

# attach iam policy
resource "aws_iam_role_policy_attachment" "ec2_full_access" {
  role       = aws_iam_role.ec2_admin_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
}

# create Instance Profile
resource "aws_iam_instance_profile" "ec2_admin_instance_profile" {
  name = "${var.tags["name"]}-ec2-admin-profile"
  role = aws_iam_role.ec2_admin_role.name
}

