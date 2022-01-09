resource "aws_subnet" "dev-subnet" {
  vpc_id            = var.dev-vpc-id
  cidr_block        = var.subnet-cidr-block
  availability_zone = var.az
  tags              = var.tag
}

resource "aws_internet_gateway" "dev-igt" {
  vpc_id = var.dev-vpc-id
  tags   = var.tag
  
}

resource "aws_route_table" "dev-rt" {
  vpc_id = var.dev-vpc-id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.dev-igt.id
  }
  tags = var.tag
}

resource "aws_route_table_association" "dev-subnet-rt-association" {
  subnet_id      = aws_subnet.dev-subnet.id
  route_table_id = aws_route_table.dev-rt.id
}