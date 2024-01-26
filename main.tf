# Main VPC
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "main-vpc"
  }
}

# Creates the internet gateway, nat gateway, route tables and corresponding associations
module "networking" {
  source          = "./modules/networking"
  vpc             = aws_vpc.main
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
  nat_zone        = var.nat_zone
}

# Creates Security groups for the ec2 instances and the load balancer
module "security_groups" {
  source = "./modules/security_groups"
  vpc    = aws_vpc.main
}
