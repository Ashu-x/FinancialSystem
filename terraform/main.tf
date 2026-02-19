# -----------------------------------------------------------
# Terraform config – provisions 1 EC2 with Docker, pulls
# your image from Docker Hub, and runs it on port 8000.
# -----------------------------------------------------------

terraform {
  required_version = ">= 1.6.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# ---- Security Group ----
resource "aws_security_group" "app_sg" {
  name        = "finance-sg"
  description = "Allow SSH and app traffic"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]   # restrict to your IP in production
  }

  ingress {
    description = "App port"
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "finance-sg"
  }
}

# ---- Auto-lookup latest Amazon Linux 2023 AMI ----
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# ---- EC2 Instance ----
resource "aws_instance" "app_ec2" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = var.instance_type
  key_name               = var.key_pair_name
  vpc_security_group_ids = [aws_security_group.app_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              set -e
              # Amazon Linux uses yum/dnf
              yum update -y
              yum install -y docker
              systemctl enable docker
              systemctl start docker
              docker pull ${var.dockerhub_image}
              docker run -d --name finance-system --restart always -p 8000:8000 ${var.dockerhub_image}
              EOF

  tags = {
    Name = "finance-app"
  }
}