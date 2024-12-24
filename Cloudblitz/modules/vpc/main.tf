resource "aws_vpc" "my_vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "${var.name}-vpc"
    Env = var.env
  }
}
 resource "aws_subnet" "public_subnet" {
    vpc_id = aws_vpc.my_vpc.id
    cidr_block = var.pub_sub_cidr
    availability_zone = var.az1
    map_public_ip_on_launch = true

    tags = {
      Name = "${var.name}-public-subnet"
      Env = var.env
    }
   
 }
 resource "aws_subnet" "private_subnet" {
    vpc_id = aws_vpc.my_vpc.id
    cidr_block = var.pri_sub_cidr
   availability_zone = var.az1
    
    tags = {
      Name = "${var.name}-private-subnet"
      Env = var.env
    }
   }

   resource "aws_internet_gateway" "my_igw" {
    vpc_id = aws_vpc.my_vpc.id

    tags = {
      Name = "${var.name}-igw"
      Env = var.env
    }

}

resource "aws_default_route_table" "drt" {
  default_route_table_id = aws_vpc.my_vpc.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }

  tags = {
    Name = "${var.name}-route-table"
    Env  = var.env
  }
}

