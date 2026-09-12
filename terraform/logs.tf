resource "aws_cloudwatch_log_group" "autodeployx" {
  name              = "/ecs/autodeployx"
  retention_in_days = 7

  tags = {
    Name        = "autodeployx-logs"
    Project     = "AutoDeployX"
    Environment = "dev"
  }
}
