resource "aws_ecr_repository" "autodeployx" {
  name                 = "autodeployx"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name        = "autodeployx-ecr"
    Project     = "AutoDeployX"
    Environment = "dev"
  }
}
