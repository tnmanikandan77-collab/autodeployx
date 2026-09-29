resource "aws_cloudwatch_metric_alarm" "ecs_cpu_high" {
  alarm_name        = "autodeployx-ecs-cpu-high"
  alarm_description = "Alert when AutoDeployX ECS CPU utilization is high"

  namespace          = "AWS/ECS"
  metric_name        = "CPUUtilization"
  statistic          = "Average"
  period             = 60
  evaluation_periods = 2

  threshold           = 70
  comparison_operator = "GreaterThanThreshold"

  dimensions = {
    ClusterName = aws_ecs_cluster.autodeployx.name
    ServiceName = aws_ecs_service.autodeployx.name
  }

  treat_missing_data = "notBreaching"

  tags = {
    Name    = "autodeployx-ecs-cpu-high"
    Project = "AutoDeployX"
  }
}
resource "aws_cloudwatch_metric_alarm" "ecs_memory_high" {
  alarm_name        = "autodeployx-ecs-memory-high"
  alarm_description = "Alert when AutoDeployX ECS memory utilization is high"

  namespace          = "AWS/ECS"
  metric_name        = "MemoryUtilization"
  statistic          = "Average"
  period             = 60
  evaluation_periods = 2

  threshold           = 80
  comparison_operator = "GreaterThanThreshold"

  dimensions = {
    ClusterName = aws_ecs_cluster.autodeployx.name
    ServiceName = aws_ecs_service.autodeployx.name
  }

  treat_missing_data = "notBreaching"

  tags = {
    Name    = "autodeployx-ecs-memory-high"
    Project = "AutoDeployX"
  }
}
