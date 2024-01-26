resource "aws_lb" "main" {
  name               = "web-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [module.security_groups.lb.id]
  subnets            = [for subnet in module.networking.public_subnets : subnet.id]
}

resource "aws_lb_target_group" "main" {
  #name    = "web-target-group" #Let it pick a random name so it's able to actually create before destroying
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    port                = 80
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  lifecycle {
    create_before_destroy = true
  }
  tags = {
    Name = "instance-target-group"
  }
}

# Redirect http to https
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.main.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.main.arn
  port              = 443
  protocol          = "HTTPS"

  ssl_policy      = "ELBSecurityPolicy-2016-08"
  certificate_arn = aws_acm_certificate.main.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main.arn
  }
}
