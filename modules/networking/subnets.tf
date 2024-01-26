resource "aws_subnet" "public" {
  for_each          = tomap(var.public_subnets)
  availability_zone = each.key
  cidr_block        = each.value
  vpc_id            = var.vpc.id
}

resource "aws_subnet" "private" {
  for_each          = tomap(var.private_subnets)
  availability_zone = each.key
  cidr_block        = each.value
  vpc_id            = var.vpc.id
}
