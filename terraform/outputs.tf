output "vpc_id" {
  description = "ID of the AutoDeployX VPC"
  value       = aws_vpc.autodeployx_vpc.id
}

output "ecr_repository_url" {
  description = "ECR repository URL"
  value       = aws_ecr_repository.autodeployx.repository_url
}

output "public_subnet_ids" {
  description = "Public subnet IDs"
  value = [
    aws_subnet.public_1.id,
    aws_subnet.public_2.id
  ]
}

output "private_subnet_ids" {
  description = "Private subnet IDs"
  value = [
    aws_subnet.private_1.id,
    aws_subnet.private_2.id
  ]
}
output "alb_dns_name" {
  description = "Application Load Balancer DNS name"
  value       = aws_lb.autodeployx.dns_name
}
