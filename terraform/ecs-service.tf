resource "aws_security_group" "ecs" {
  name        = "autodeployx-ecs-sg"
  description = "Allow traffic from ALB to ECS tasks"
  vpc_id      = aws_vpc.autodeployx_vpc.id

  ingress {
    description     = "HTTP from ALB"
    from_port       = 8080
    to_port         = 8080
    protocol        = "tcp"
    security_groups = [aws_security_group.alb.id]
  }

  egress {
    description = "Allow outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "autodeployx-ecs-sg"
    Project = "AutoDeployX"
  }
}
resource "aws_ecs_service" "autodeployx" {
  name            = "autodeployx-service"
  cluster         = aws_ecs_cluster.autodeployx.id
  task_definition = aws_ecs_task_definition.autodeployx.arn

  desired_count = 2

  launch_type = "FARGATE"

  network_configuration {
    subnets = [
      aws_subnet.public_1.id,
      aws_subnet.public_2.id
    ]

    security_groups = [
      aws_security_group.ecs.id
    ]

    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.autodeployx.arn
    container_name   = "autodeployx"
    container_port   = 8080
  }

  health_check_grace_period_seconds = 60

  depends_on = [
    aws_lb_listener.http
  ]

  tags = {
    Name        = "autodeployx-service"
    Project     = "AutoDeployX"
    Environment = "dev"
  }
}

