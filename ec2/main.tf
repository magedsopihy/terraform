
resource "aws_vpc" "dev-vpc" {
  cidr_block = var.vpc-cidr-block
  tags       = var.tag
}

module "dev-subnet" {
  source = "./modules/subnets"
  dev-vpc-id = aws_vpc.dev-vpc.id
  subnet-cidr-block = var.subnet-cidr-block 
  az = var.az
  tag =var.tag
  }

module "dev-webserver" {
  source = "./modules/webserver"
  dev-vpc-id = aws_vpc.dev-vpc.id
  subnet-id = module.dev-subnet.subnet.id
  instance-type = var.instance-type
  az = var.az
  tag =var.tag 
  private_key_location = var.private_key_location
}






