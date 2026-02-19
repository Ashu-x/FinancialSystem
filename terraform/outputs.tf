# -----------------------------------------------------------
# Printed after `terraform apply` so you know where to go.
# -----------------------------------------------------------

output "instance_id" {
  description = "EC2 instance ID"
  value       = aws_instance.app_ec2.id
}

output "public_ip" {
  description = "Open http://<this-ip>:8000 in browser"
  value       = aws_instance.app_ec2.public_ip
}

output "ssh_command" {
  description = "SSH into the instance"
  value       = "ssh -i <your-key>.pem ec2-user@${aws_instance.app_ec2.public_ip}"
}
