resource "aws_internet_gateway" "main" {
  vpc_id = var.vpc.id

  tags = {
    Name = "main-igw"
  }
}

resource "aws_eip" "main" {
  domain = "vpc"
}

resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.main.id
  subnet_id     = aws_subnet.public[var.nat_zone].id
  tags = {
    Name = "main-ngw"
  }
}
