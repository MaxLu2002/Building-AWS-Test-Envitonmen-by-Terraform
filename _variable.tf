# ---------- Adjustable Setting 
# region: ap-northeast-1
    # x86ID = "ami-0bf4c288973b2f12b"
    # armID = "ami-0b86b628eb7332756"

# region: ap-northeast-2
    # x86ID = "ami-0e18fe6ecdad223e5"
    # armID = "ami-011fb2b8814373313"

# ---------- define provider ----------
provider "aws" {
  region  = var.region
  profile = "account1"
}

# ---------- define region ----------
variable "region" {
  type = string
  default = "ap-northeast-2"
}

# ---------- define tags ----------
variable "tags" {
  type = map(string)
  default = {
    name = "test"
  }
}

# define bucket name
variable "bucket_names" {
  type    = list(string)
  default = ["test-terraform-1", "test-terraform-2", "test-terraform-3"]
}

# define ec2 ami and size 
variable "EC2_AMI" {
  type = map(string)
  default = {
    x86ID = "ami-0e18fe6ecdad223e5"
    armID = "ami-011fb2b8814373313"
  }
}

variable "EC2_size" {
  type = map(string)
  default = {
    t3micro  = "t3.micro"
    t4gmicro = "t4g.micro"
  }
}

