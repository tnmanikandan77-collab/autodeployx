# 🚀 AutoDeployX – Self-Healing AWS Deployment Platform

AutoDeployX is a DevOps project that demonstrates an automated application deployment workflow using AWS, Jenkins, Docker, Terraform, and Amazon ECS Fargate.

The project combines CI/CD automation, containerization, Infrastructure as Code, application monitoring, auto scaling, and ECS task recovery into a single deployment workflow.

---

## 🏗️ Architecture

```text
Developer
    |
    v
GitHub
    |
    v
Jenkins (EC2)
    |
    +--> Automated Tests
    |
    +--> Docker Build
    |
    v
Amazon ECR
    |
    v
Amazon ECS Fargate
    |
    v
Application Load Balancer
    |
    v
Flask Application
    |
    +--> /health
    |
    +--> /version

Amazon CloudWatch
    |
    +--> Logs
    +--> CPU Metrics
    +--> Memory Metrics
    +--> Alarms
Terraform is used to provision and manage the AWS infrastructure

##🛠️ Technology Stack


AWS
Amazon ECS Fargate
Amazon ECR
Application Load Balancer
Amazon CloudWatch
Terraform
Jenkins
Docker
Git & GitHub
Python
Flask
Pytest


#⚙️ CI/CD Workflow

The deployment workflow is:

GitHub Push
     |
     v
Jenkins
     |
     v
Checkout
     |
     v
Automated Tests
     |
     v
Docker Build
     |
     v
Push Image to ECR
     |
     v
Register ECS Task Definition
     |
     v
Update ECS Service
     |
     v
Wait for ECS Stability
     |
     v
Application Verification

A push to the main branch triggers the Jenkins pipeline.

# Jenkins Pipeline

The Jenkins pipeline contains the following stages:

Checkout
Test
Docker Build
Push to ECR
Deploy to ECS

The pipeline automatically builds and deploys a new application version without requiring manual deployment commands.

# Automated Testing

Before deployment, Jenkins runs the application's automated tests using Pytest.

If the tests fail, the pipeline stops and the deployment does not proceed.

This provides a basic quality gate before the application is deployed to AWS.

# Docker

The Flask application is packaged into a Docker container.

Docker images are tagged using the Jenkins build number.

Example:

autodeployx:build-9

The image is then pushed to Amazon ECR.

This provides traceability between a Jenkins build and the container image deployed to ECS.

# Amazon ECR

Amazon Elastic Container Registry (ECR) is used as the private container registry for AutoDeployX.

The Jenkins pipeline:

Authenticates with ECR.
Tags the Docker image.
Pushes the image to the ECR repository.

Example:

480749290130.dkr.ecr.us-east-1.amazonaws.com/autodeployx:build-9


# Amazon ECS Fargate

The application runs as a service on Amazon ECS using Fargate.

The ECS service is configured with:

Desired task count: 2
Minimum tasks: 2
Maximum tasks: 4
Application container port: 8080

The Application Load Balancer distributes traffic across healthy ECS tasks.



# Application Verification

The application exposes health and version endpoints.

Health Check
GET /health

Example response:

{
  "status": "healthy"
}
Version Check
GET /version

Example response:

{
  "application": "AutoDeployX",
  "version": "2.0.0"
}

These endpoints were used to verify that the deployed application was healthy and running the expected version.



# Application Load Balancer

The Application Load Balancer provides the public HTTP entry point for the application.

Traffic is distributed to healthy ECS tasks running the Flask application on port 8080.

The ALB health check uses the application's /health endpoint.



# CloudWatch Monitoring

Amazon CloudWatch is used for application and ECS monitoring.

The project includes:

ECS application logs
CPU utilization metrics
Memory utilization metrics
ECS service metrics
CPU utilization alarm
Memory utilization alarm

Application logs are stored in:

/ecs/autodeployx

CloudWatch provides visibility into application activity and resource utilization.



# ECS Auto Scaling

ECS Service Auto Scaling is configured to adjust the number of running tasks based on resource utilization.

The service can scale between:

Minimum: 2 tasks
Maximum: 4 tasks

CPU utilization is used as a scaling signal.

This allows the application capacity to increase when workload demand increases.

# Self-Healing

One of the key demonstrations of AutoDeployX is ECS automatic task replacement.

During testing, a running ECS task was intentionally stopped.

Before failure:

Desired: 2
Running: 2

After intentionally stopping one task:

Desired: 2
Running: 1

ECS detected that the service was below its desired task count and automatically launched a replacement task.

After recovery:

Desired: 2
Running: 2

This demonstrates ECS service-level self-healing through automatic task replacement without manually launching a replacement container.

# Infrastructure as Code

Terraform is used to provision and manage the AWS infrastructure.

The Terraform configuration manages resources including:

VPC
Public subnets
Private subnets
Internet Gateway
Route tables
Security groups
Application Load Balancer
ECS cluster
ECS service
ECS task definition
ECR repository
IAM roles
Jenkins EC2 infrastructure
CloudWatch log group
CloudWatch alarms
ECS auto scaling

Infrastructure changes can be reviewed through Terraform plans before being applied.


# Project Structure


autodeployx/
│
├── app.py
├── Dockerfile
├── README.md
├── requirements.txt
│
├── tests/
│
└── terraform/
    ├── ecs-service.tf
    ├── task-definition.tf
    ├── jenkins.tf
    ├── jenkins-iam.tf
    ├── monitoring.tf
    └── ...



# Security Considerations

The project uses AWS IAM roles for AWS resource access instead of hard-coding AWS credentials into the application.

Secrets and credentials should not be committed to GitHub.

Terraform state files, environment files, private keys, and access tokens should also be excluded from version control.




# Project Outcome

AutoDeployX demonstrates an end-to-end DevOps workflow:

Code Commit
     ↓
Automated Testing
     ↓
Docker Build
     ↓
Amazon ECR
     ↓
Amazon ECS Fargate
     ↓
Application Load Balancer
     ↓
CloudWatch Monitoring
     ↓
Auto Scaling
     ↓
Self-Healing

The project demonstrates how AWS cloud services, CI/CD automation, containers, Infrastructure as Code, monitoring, scaling, and automatic task recovery can be combined into a practical DevOps deployment platform.




# Key Learning Outcomes

Through this project, I gained hands-on experience with:

AWS cloud infrastructure
Terraform Infrastructure as Code
Jenkins CI/CD pipelines
Docker containerization
Amazon ECR
Amazon ECS Fargate
Application Load Balancing
CloudWatch monitoring
ECS auto scaling
ECS task recovery
Application health checks
CI/CD troubleshooting
AWS infrastructure troubleshooting


#💻 Author

Manikandan

GitHub:https://github.com/tnmanikandan77-collab
