resource "aws_security_group" "jenkins" {
  name        = "autodeployx-jenkins-sg"
  description = "Allow Jenkins access"
  vpc_id      = aws_vpc.autodeployx_vpc.id

  ingress {
    description = "Jenkins web UI"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
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
    Name    = "autodeployx-jenkins-sg"
    Project = "AutoDeployX"
  }
}

resource "aws_instance" "jenkins" {
  ami           = "ami-0b5358cc8c5df0b02"
  instance_type = "t3.small"
  key_name      = "autodeployx-jenkins-key"

  subnet_id = aws_subnet.public_1.id

  vpc_security_group_ids = [
    aws_security_group.jenkins.id
  ]

  associate_public_ip_address = true

  iam_instance_profile = aws_iam_instance_profile.jenkins.name

  user_data = <<-EOF
              #!/bin/bash

              dnf update -y

              dnf install -y java-21-amazon-corretto git docker

              systemctl enable --now docker

              usermod -aG docker ec2-user

              wget -O /etc/yum.repos.d/jenkins.repo \
                https://pkg.jenkins.io/redhat-stable/jenkins.repo

              rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key

              dnf install -y jenkins

              systemctl enable --now jenkins
              EOF

  tags = {
    Name        = "autodeployx-jenkins"
    Project     = "AutoDeployX"
    Environment = "dev"
  }
}
