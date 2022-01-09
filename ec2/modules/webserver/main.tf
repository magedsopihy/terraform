resource "aws_security_group" "dev-sg" {
  vpc_id = var.dev-vpc-id
  name   = "dev-sg"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["156.199.129.210/32"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
    prefix_list_ids = []
  }

  tags = var.tag
}


data "aws_ami" "latest-linux-amazon-image" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_instance" "dev-ec2" {
  ami                         = data.aws_ami.latest-linux-amazon-image.id
  instance_type               = var.instance-type
  security_groups             = [aws_security_group.dev-sg.id]
  subnet_id                   = var.subnet-id
  availability_zone           = var.az
  associate_public_ip_address = true
  key_name                    = "magedhesham"

  provisioner "local-exec" {
    working_dir = "/home/maged/ansible/docker-on-ec2"
    command     = "ansible-playbook --inventory ${self.public_ip}, --private-key ${var.private_key_location} --user ec2-user playbook.yaml"
  }
}
