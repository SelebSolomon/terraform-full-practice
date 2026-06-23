resource "aws_vpc" "basic_vpc" {
  cidr_block       = "10.0.0.0/16"

  tags = {
    Name = "vpc-practice"
  }
}

resource "aws_subnet" "public" {
  count                   = length(var.azs)
  vpc_id                  = aws_vpc.basic_vpc.id
  cidr_block             = var.public_subnets[count.index]
  availability_zone      = var.azs[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "public-${var.azs[count.index]}"
  }
}

resource "aws_subnet" "private" {
  count             = length(var.azs)
  vpc_id            = aws_vpc.basic_vpc.id
  cidr_block        = var.private_subnets[count.index]
  availability_zone = var.azs[count.index]

  tags = {
    Name = "private-${var.azs[count.index]}"
  }
}


resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.basic_vpc.id
  

  tags = {
    Name = "internet-gateway"
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
  count = length(var.azs)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.route_rt.id
}



resource "aws_eip" "nat" {
  count  = length(var.azs)
  domain = "vpc"
}

resource "aws_nat_gateway" "nat" {
  count         = length(var.azs)
  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = aws_subnet.public[count.index].id

  tags = {
    Name = "nat-${var.azs[count.index]}"
  }

  depends_on = [aws_internet_gateway.igw]
}




resource "aws_route_table" "private_rt" {
  count  = length(var.azs)
  vpc_id = aws_vpc.basic_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat[count.index].id
  }

  tags = {
    Name = "private-rt-${var.azs[count.index]}"
  }
}

resource "aws_route_table_association" "private" {
  count          = length(var.azs)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private_rt[count.index].id
}