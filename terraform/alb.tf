resource "aws_security_group" "alb" {
  name        = "autodeployx-alb-sg"
  description = "Allow HTTP traffic to AutoDeployX ALB"
  vpc_id      = aws_vpc.autodeployx_vpc.id

  ingress {
    description = "HTTP from internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "autodeployx-alb-sg"
    Project = "AutoDeployX"
  }
}

resource "aws_lb" "autodeployx" {
  name               = "autodeployx-alb"
  internal           = false
  load_balancer_type = "application"

  security_groups = [
    aws_security_group.alb.id
  ]

  subnets = [
    aws_subnet.public_1.id,
    aws_subnet.public_2.id
  ]

  tags = {
    Name    = "autodeployx-alb"
    Project = "AutoDeployX"
  }
}

resource "aws_lb_target_group" "autodeployx" {
  name        = "autodeployx-tg"
  port        = 8080
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = aws_vpc.autodeployx_vpc.id

  health_check {
    enabled             = true
    path                = "/health"
    protocol            = "HTTP"
    port                = "traffic-port"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
    matcher             = "200"
  }

  tags = {
    Name    = "autodeployx-target-group"
    Project = "AutoDeployX"
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.autodeployx.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.autodeployx.arn
  }
}
