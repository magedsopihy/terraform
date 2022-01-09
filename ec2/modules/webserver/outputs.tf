output "public-IP" {
    value = aws_instance.dev-ec2.public_ip
}