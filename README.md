# 🚀 AutoDeployX – Self-Healing AWS Deployment Platform

AutoDeployX is an automated DevOps deployment platform built using AWS, Jenkins, Docker, Terraform, and Amazon ECS Fargate.

The project demonstrates an end-to-end CI/CD workflow with automated testing, containerization, cloud deployment, monitoring, auto scaling, and self-healing.

---

## 🏗️ Architecture

GitHub → Jenkins → Docker → Amazon ECR → Amazon ECS Fargate → Application Load Balancer → Application

Terraform is used to provision and manage the AWS infrastructure, while Amazon CloudWatch provides monitoring, logs, metrics, and alarms.

---

## 🛠️ Technology Stack

- AWS
- Amazon ECS Fargate
- Amazon ECR
- Application Load Balancer
- Amazon CloudWatch
- Terraform
- Jenkins
- Docker
- Git & GitHub
- Python / Flask
- Pytest

---

## ⚙️ CI/CD Workflow

1. Developer pushes code to GitHub.
2. Jenkins detects the GitHub push.
3. Jenkins checks out the source code.
4. Automated tests are executed.
5. Docker image is built.
6. Docker image is tagged using the Jenkins build number.
7. Image is pushed to Amazon ECR.
8. Jenkins registers a new ECS task definition.
9. ECS service is updated with the new task definition.
10. ECS waits for the service to become stable.
11. Application is verified through health and version endpoints.

---

## 🔄 Jenkins Pipeline

The Jenkins pipeline contains the following stages:

- Checkout
- Test
- Docker Build
- Push to ECR
- Deploy to ECS

This automates the complete application deployment process.

---

## 🐳 Docker

The Python Flask application is containerized using Docker.

Docker images are tagged using the Jenkins build number, providing traceability between CI/CD builds and deployed versions.

Example:

`build-9`

---

## ☁️ AWS Infrastructure

Terraform provisions and manages:

- VPC
- Public and private subnets
- Security groups
- Application Load Balancer
- ECS cluster
- ECS service
- ECS task definition
- ECR repository
- IAM roles
- CloudWatch log group
- CloudWatch alarms
- ECS auto scaling

---

## 🚀 ECS Fargate Deployment

The application runs on Amazon ECS Fargate.

The ECS service maintains a desired count of 2 tasks under normal conditions.

Auto scaling is configured to scale the service between 2 and 4 tasks based on resource utilization.

---

## 🔍 Application Verification

The application exposes health and version endpoints.

### Health Check

`GET /health`

```json
{
  "status": "healthy"
}

#Version Check

#GET /version

{
  "application": "AutoDeployX",
  "version": "2.0.0"
}

#Monitoring

Amazon CloudWatch is used for:

ECS application logs
CPU utilization
Memory utilization
ECS service monitoring
CPU alarms
Memory alarms

CloudWatch provides visibility into the health and performance of the deployed service.

#🛡️ Self-Healing

AutoDeployX demonstrates ECS self-healing through automatic task replacement.

During testing, a running ECS task was intentionally stopped.

The ECS service temporarily changed from:

Desired: 2 | Running: 1

ECS automatically detected that the service was below the desired capacity and launched a replacement task.

The service returned to:

Desired: 2 | Running: 2

This demonstrates automatic workload recovery without manually launching a replacement container.

#🧪 Testing

Automated application tests are executed during the Jenkins pipeline before the Docker image is built.

If the tests fail, the pipeline stops and the deployment does not proceed.


.

##📁 Project Structure


autodeployx/
├── app.py
├── Dockerfile
├── Jenkinsfile
├── README.md
├── requirements.txt
├── terraform/
└── tests/


##🎯 Project Outcome

AutoDeployX demonstrates a complete DevOps workflow:

GitHub → CI/CD → Automated Testing → Docker → ECR → ECS Fargate → ALB → CloudWatch → Auto Scaling → Self-Healing

The project provides hands-on experience with AWS cloud infrastructure, CI/CD automation, containerization, Infrastructure as Code, monitoring, scaling, and failure recovery.

#👨‍💻 Author

Manikandan

GitHub: tnmanikandan77-collab
