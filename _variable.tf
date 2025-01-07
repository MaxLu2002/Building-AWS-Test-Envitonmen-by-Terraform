# ---------- Adjustable Setting 
# region: ap-northeast-1
# x86ID = "ami-0bf4c288973b2f12b"
# armID = "ami-0b86b628eb7332756"

# region: ap-northeast-2
# x86ID = "ami-0e18fe6ecdad223e5"
# armID = "ami-011fb2b8814373313"
# c6g4xlargeAMI = "ami-090a5c6f86b8b8c75"
# c6g8xlargeAMI = "ami-090a5c6f86b8b8c75d"

# ---------- define provider ----------
provider "aws" {
  region  = var.region
  profile = "sa"
}

# ---------- define region ----------
variable "region" {
  type    = string
  default = "ap-northeast-2"
}

# ---------- define tags ----------
variable "tags" {
  type = map(string)
  default = {
    name = "max-test"
  }
}

# define bucket name
variable "bucket_names" {
  type    = list(string)
  default = ["max-test-terraform-1", "max-test-terraform-2", "max-test-terraform-3"]
}

# define ec2 ami and size 
variable "EC2_AMI" {
  type = map(string)
  default = {
    x86ID             = "ami-0e18fe6ecdad223e5"
    armID             = "ami-011fb2b8814373313"
    c6g4xlargeAMI     = "ami-090a5c6f86b8b8c75"
    c6g8xlargeAMI     = "ami-090a5c6f86b8b8c75"
    win_2016_corebase = "ami-05834e674b5546f29"

  }
}

variable "EC2_size" {
  type = map(string)
  default = {
    t3micro    = "t3.micro"
    t3small    = "t3.small"
    t3alarge   = "t3a.large"
    t4gmicro   = "t4g.micro"
    c6g4xlarge = "c6g.4xlarge"
    c6g8xlarge = "c6g.8xlarge"
  }
}

