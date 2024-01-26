resource "aws_security_group" "instance" {
  vpc_id = var.vpc.id
  name   = "ec2_Instance"
  #tags
}

resource "aws_security_group" "lb" {
  vpc_id = var.vpc.id
  name   = "Load_Balancer"
  #tags
}
