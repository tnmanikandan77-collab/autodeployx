resource "aws_ecs_cluster" "autodeployx" {
  name = "autodeployx-cluster"

  tags = {
    Name        = "autodeployx-cluster"
    Project     = "AutoDeployX"
    Environment = "dev"
  }
}
