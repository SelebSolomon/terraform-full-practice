resource "aws_vpc" "basic_vpc" {
  cidr_block       = "10.0.0.0/16"

  tags = {
    Name = "main"
  }
}

resource "aws_subnet" "subnet_one" {
  vpc_id     = aws_vpc.basic_vpc.id
  cidr_block = var.subnet_one
  map_public_ip_on_launch = true

  tags = {
    Name = "Public-subnet-1"
  }
}

resource "aws_subnet" "subnet_two" {
  vpc_id     = aws_vpc.basic_vpc.id
  cidr_block = var.subnet_two
  map_public_ip_on_launch = true

  tags = {
    Name = "Public-subnet-2"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.basic_vpc.id
  

  tags = {
    Name = "main"
  }
}

resource "aws_route_table" "route_rt" {
  vpc_id = aws_vpc.basic_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }


  tags = {
    Name = "public-route-table"
  }
}


resource "aws_route_table_association" "public_one" {
  subnet_id      = aws_subnet.subnet_one.id
  route_table_id = aws_route_table.route_rt.id
}

resource "aws_route_table_association" "public_two" {
  subnet_id      = aws_subnet.subnet_two.id
  route_table_id = aws_route_table.route_rt.id
}