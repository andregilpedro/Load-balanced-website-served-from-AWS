resource "aws_route_table" "public" {
  vpc_id = var.vpc.id
}

resource "aws_route_table" "outbound" {
  vpc_id = var.vpc.id
}
