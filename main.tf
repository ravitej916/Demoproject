provider "aws" {
  region = "us-east-1"
}

module "ec2" {
  source = "./ec2"
}

module "alb" {
  source = "./alb"
}

module "security_groups" {
  source = "./security-groups"
}
