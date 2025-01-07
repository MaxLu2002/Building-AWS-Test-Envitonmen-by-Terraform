# Public Security Group (allow SSH and HTTP)
resource "aws_security_group" "public_sg" {
  vpc_id      = aws_vpc.main_vpc.id
  description = "Allow SSH and HTTP"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 1500
    to_port     = 1500
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]

  }

  tags = {
    Name = "${var.tags["name"]}-public-sg"
  }
}

# Private Security Group (allow traffic from Public SG)
resource "aws_security_group" "private_sg" {
  vpc_id      = aws_vpc.main_vpc.id
  description = "Allow traffic from Public SG"

  ingress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    security_groups = [aws_security_group.public_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]

  }
  tags = {
    Name = "${var.tags["name"]}-private-sg"
  }
}

# public ec2-1
resource "aws_instance" "public_ec2_1" {
  ami                    = var.EC2_AMI.win_2016_corebase
  instance_type          = var.EC2_size.t3alarge
  subnet_id              = aws_subnet.public_subnet_1.id
  vpc_security_group_ids = [aws_security_group.public_sg.id] # 使用 security group ID

  # attach iam role
  iam_instance_profile = aws_iam_instance_profile.ec2_admin_instance_profile.name

  tags = {
    Name = "${var.tags["name"]}-public-ec2-1"
  }
}

# public ec2-2
resource "aws_instance" "public_ec2_2" {
  ami                    = var.EC2_AMI.win_2016_corebase
  instance_type          = var.EC2_size.t3alarge
  subnet_id              = aws_subnet.public_subnet_2.id
  vpc_security_group_ids = [aws_security_group.public_sg.id] # 使用 security group ID

  # attach iam role
  iam_instance_profile = aws_iam_instance_profile.ec2_admin_instance_profile.name

  tags = {
    Name = "${var.tags["name"]}-public-ec2-2"
  }
}

# private ec2-1
resource "aws_instance" "private_ec2_1" {
  ami                    = var.EC2_AMI.x86ID
  instance_type          = var.EC2_size.t3micro
  subnet_id              = aws_subnet.private_subnet_1.id
  vpc_security_group_ids = [aws_security_group.private_sg.id] # 使用 security group ID

  # attach iam role
  iam_instance_profile = aws_iam_instance_profile.ec2_admin_instance_profile.name

  tags = {
    Name = "${var.tags["name"]}-private-ec2-1"
  }
}

# private ec2-2
resource "aws_instance" "private_ec2_2" {
  ami                    = var.EC2_AMI.x86ID
  instance_type          = var.EC2_size.t3micro
  subnet_id              = aws_subnet.private_subnet_2.id
  vpc_security_group_ids = [aws_security_group.private_sg.id] # 使用 security group ID

  # attach iam role
  iam_instance_profile = aws_iam_instance_profile.ec2_admin_instance_profile.name

  tags = {
    Name = "${var.tags["name"]}-private-ec2-2"
  }
}
