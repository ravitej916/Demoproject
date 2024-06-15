resource "aws_lb" "app_lb" {
  name               = "app-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = ["subnet-0123456789abcdef0", "subnet-0123456789abcdef1"]

  enable_deletion_protection = false
}

resource "aws_lb_target_group" "target_group" {
  name     = "target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "vpc-0123456789abcdef0"
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.app_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group.arn
  }
}

resource "aws_lb_target_group_attachment" "web_server" {
  target_group_arn = aws_lb_target_group.target_group.arn
  target_id        = module.ec2.instance_id
  port             = 80
}

output "dns_name" {
  value = aws_lb.app_lb.dns_name
}
