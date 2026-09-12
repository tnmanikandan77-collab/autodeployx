data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_subnet" "public_1" {
  vpc_id                  = aws_vpc.autodeployx_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true

  tags = {
    Name    = "autodeployx-public-1"
    Project = "AutoDeployX"
  }
}

resource "aws_subnet" "public_2" {
  vpc_id                  = aws_vpc.autodeployx_vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = data.aws_availability_zones.available.names[1]
  map_public_ip_on_launch = true

  tags = {
    Name    = "autodeployx-public-2"
    Project = "AutoDeployX"
  }
}

resource "aws_subnet" "private_1" {
  vpc_id            = aws_vpc.autodeployx_vpc.id
  cidr_block        = "10.0.11.0/24"
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name    = "autodeployx-private-1"
    Project = "AutoDeployX"
  }
}

resource "aws_subnet" "private_2" {
  vpc_id            = aws_vpc.autodeployx_vpc.id
  cidr_block        = "10.0.12.0/24"
  availability_zone = data.aws_availability_zones.available.names[1]

  tags = {
    Name    = "autodeployx-private-2"
    Project = "AutoDeployX"
  }
}

resource "aws_internet_gateway" "autodeployx_igw" {
  vpc_id = aws_vpc.autodeployx_vpc.id

  tags = {
    Name    = "autodeployx-igw"
    Project = "AutoDeployX"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.autodeployx_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.autodeployx_igw.id
  }

  tags = {
    Name    = "autodeployx-public-rt"
    Project = "AutoDeployX"
  }
}

resource "aws_route_table_association" "public_1" {
  subnet_id      = aws_subnet.public_1.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_2" {
  subnet_id      = aws_subnet.public_2.id
  route_table_id = aws_route_table.public.id
}
