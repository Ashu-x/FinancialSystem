# -----------------------------------------------------------
# Declares all configurable inputs.
# Actual values go in terraform.tfvars (not here).
# -----------------------------------------------------------

variable "aws_region" {
  description = "AWS region to deploy into"
  type        = string
  default     = "ap-south-1"
}

variable "ami_id" {
  description = "AMI ID for Amazon Linux 2023 in your region"
  type        = string
  # Default: Amazon Linux 2023 in ap-south-1 (verify in AWS console)
  default     = "ami-0614b7e6c7d68c497"
}

variable "instance_type" {
  description = "EC2 instance size"
  type        = string
  default     = "t3.micro"
}

variable "key_pair_name" {
  description = "Name of your EC2 key pair (created in AWS console)"
  type        = string
}

variable "dockerhub_image" {
  description = "Docker Hub image (e.g. yourusername/finance-system:latest)"
  type        = string
}
