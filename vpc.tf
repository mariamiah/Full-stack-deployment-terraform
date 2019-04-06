# Resource creates a virtual private cloud to hold the different subnets
resource "aws_vpc" "default" {
  cidr_block = "${var.vpc_cidr}"
  enable_dns_hostnames = true
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  tags {
    Name = "storeManagerVPC"
  }
}

# Resource creates the public subnet to hold the NAT instance
resource "aws_subnet" "public-subnet-a" {
  vpc_id = "${aws_vpc.default.id}"
  cidr_block = "${var.public_subnet_a_cidr}"
  availability_zone = "eu-west-2a"

  tags {
    Name = "NAT-subnet"
  }
}
# Resource creates a public subnet to hold the Web Server instance
resource "aws_subnet" "public-subnet-b" {
  vpc_id = "${aws_vpc.default.id}"
  cidr_block = "${var.public_subnet_b_cidr}"
  availability_zone = "eu-west-2b"

  tags {
    Name = "web-server-subnet"
  }
}
# Resource creates a private subnet to hold the Database Instance
resource "aws_subnet" "private-subnet-a" {
  vpc_id = "${aws_vpc.default.id}"
  cidr_block = "${var.private_subnet_a_cidr}"
  availability_zone = "eu-west-2a"

  tags {
    Name = "Database Private Subnet"
  }
}

# Resource creates the private subnet to hold the Web API instance
resource "aws_subnet" "private-subnet-b" {
  vpc_id = "${aws_vpc.default.id}"
  cidr_block = "${var.private_subnet_b_cidr}"
  availability_zone = "eu-west-2b"

  tags {
    Name = "Store API Private Subnet"
  }
}
# Internet gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.default.id}"
  tags {
    Name = "VPC-IGW"
  }
}
# route-tables
resource "aws_route_table" "public-rtb" {
  vpc_id = "${aws_vpc.default.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gw.id}"
  }
  tags {
    Name = "public-rtb"
  }
}

resource "aws_route_table" "private-rtb" {
  vpc_id = "${aws_vpc.default.id}"

   route {
    cidr_block  = "0.0.0.0/0"
    instance_id = "${aws_instance.nat-instance.id}"
  }
  tags {
    Name = "private-rtb"
  }
}

# Associate public route table with public subnets
resource "aws_route_table_association" "public_association_subnet_a" {
  subnet_id      = "${aws_subnet.public-subnet-a.id}"
  route_table_id = "${aws_route_table.public-rtb.id}"
}

resource "aws_route_table_association" "public-association_subnet_a" {
  subnet_id      = "${aws_subnet.public-subnet-b.id}"
  route_table_id = "${aws_route_table.public-rtb.id}"
}

# Associate private subnets with private route tables
resource "aws_route_table_association" "private_subnet_a_association" {
  subnet_id      = "${aws_subnet.private-subnet-a.id}"
  route_table_id = "${aws_route_table.private-rtb.id}"
}

resource "aws_route_table_association" "private_subnet_b_association" {
  subnet_id      = "${aws_subnet.private-subnet-b.id}"
  route_table_id = "${aws_route_table.private-rtb.id}"
}
