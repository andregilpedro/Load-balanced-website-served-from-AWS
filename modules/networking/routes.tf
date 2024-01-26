# Nat gateway routing rules/associations, allow private subnets outbound access to the internet
resource "aws_route" "nat_gateway" {
  route_table_id         = aws_route_table.outbound.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_nat_gateway.main.id
}

resource "aws_route_table_association" "private" {
  for_each       = tomap(aws_subnet.private)
  subnet_id      = each.value.id
  route_table_id = aws_route_table.outbound.id
}

# Internet gateway routing rules/associations
resource "aws_route" "internet_gateway" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main.id
}

resource "aws_route_table_association" "public" {
  for_each       = tomap(aws_subnet.public)
  subnet_id      = each.value.id
  route_table_id = aws_route_table.public.id
}
