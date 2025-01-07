# create iam role
resource "aws_iam_role" "ec2_admin_role" {
  name = "${var.tags["name"]}-ec2-admin"

  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "ec2.amazonaws.com"
        },
        "Action" : "sts:AssumeRole",
        "Condition" : {
          "StringLike" : {
            "aws:SourceArn" : "arn:aws:drs:${var.region}:136184392219:*"
          },
          "StringEquals" : {
            "aws:SourceAccount" : "136184392219"
          }
        }
      }
    ]
  })
}

# attach iam policy
resource "aws_iam_role_policy_attachment" "ec2_full_access" {
  role       = aws_iam_role.ec2_admin_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
}

# attach iam policy
resource "aws_iam_role_policy_attachment" "DisasterRecoveryAgent" {
  role       = aws_iam_role.ec2_admin_role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSElasticDisasterRecoveryAgentInstallationPolicy"
}

resource "aws_iam_role_policy_attachment" "ElasticDisasterRecoveryAgentPolicy" {
  role       = aws_iam_role.ec2_admin_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSElasticDisasterRecoveryAgentPolicy"
}


# create Instance Profile
resource "aws_iam_instance_profile" "ec2_admin_instance_profile" {
  name = "${var.tags["name"]}-ec2-admin-profile"
  role = aws_iam_role.ec2_admin_role.name
}



