resource "aws_launch_template" "main" {
  name                   = "simple-httpd"
  instance_type          = var.instance_type
  vpc_security_group_ids = [module.security_groups.instance.id]

  image_id = var.instance_image_id
  key_name = aws_key_pair.ssh.key_name

  user_data = filebase64("${path.module}/template.sh")

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "main" {
  desired_capacity    = 2
  max_size            = 2
  min_size            = 2
  vpc_zone_identifier = [for subnet in module.networking.private_subnets : subnet.id]
  launch_template {
    id      = aws_launch_template.main.id
    version = "$Latest"
  }

  health_check_type         = "EC2"
  health_check_grace_period = 300

  tag {
    key                 = "Name"
    value               = "web-instance"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_attachment" "main" {
  autoscaling_group_name = aws_autoscaling_group.main.name
  lb_target_group_arn    = aws_lb_target_group.main.arn
}

resource "tls_private_key" "ssh" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "ssh" {
  key_name   = "Banana"
  public_key = tls_private_key.ssh.public_key_openssh
}
