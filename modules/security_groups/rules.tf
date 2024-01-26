resource "aws_security_group_rule" "egress_all" {
  for_each = merge(
    { instance = aws_security_group.instance.id },
    { lb = aws_security_group.lb.id },
  )
  description       = "Egress - allow all traffic_type to all ports, all IPs"
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = each.value
}

resource "aws_security_group_rule" "ingress_http" {
  for_each = merge(
    { instance = aws_security_group.instance.id },
    { lb = aws_security_group.lb.id },
  )
  protocol          = "tcp"
  from_port         = 80
  to_port           = 80
  cidr_blocks       = ["0.0.0.0/0"]
  type              = "ingress"
  security_group_id = each.value
}

resource "aws_security_group_rule" "ingress_https" {
  for_each = merge(
    { instance = aws_security_group.instance.id },
    { lb = aws_security_group.lb.id },
  )
  protocol          = "tcp"
  from_port         = 443
  to_port           = 443
  cidr_blocks       = ["0.0.0.0/0"]
  type              = "ingress"
  security_group_id = each.value
}

resource "aws_security_group_rule" "ingress_ssh" {
  protocol          = "tcp"
  from_port         = 22
  to_port           = 22
  cidr_blocks       = ["0.0.0.0/0"]
  type              = "ingress"
  security_group_id = aws_security_group.instance.id
}
