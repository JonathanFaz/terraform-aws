
resource "aws_vpc" "vpc" {
    cidr_block= "${var.vpc-cidr}"
    instance_tenancy = "default"
    enable_dns_hostnames= true
}
resource "aws_internet_gateway" "internet-gateway" {
    vpc_id    = aws_vpc.vpc.id
}


// SG to allow SSH connections from anywhere
resource "aws_security_group" "allow_ssh_pub" {
  description = "Allow SSH inbound traffic"
  vpc_id      = aws_vpc.vpc.id

  # SSH
  ingress {
    description = "SSH from the internet"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  # HTTP
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

 
}
// SG to onlly allow SSH connections from VPC public subnets
resource "aws_security_group" "allow_ssh_priv" {
  description = "Allow SSH inbound traffic"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description = "SSH only from internal VPC clients"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}
resource "aws_security_group" "mysql_sg" {
  name        = "ex_private_sg"
  description = "Used for access to the private instances"
  vpc_id      = aws_vpc.vpc.id

  # MySQL
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_subnet" "private-subnet-1" {
 vpc_id = aws_vpc.vpc.id
 cidr_block = "${var.private-subnet-1-cidr}"
 availability_zone = "us-east-1a"
 map_public_ip_on_launch = false 
}

resource "aws_subnet" "private-subnet-2" {
 vpc_id = aws_vpc.vpc.id
 cidr_block = "${var.private-subnet-2-cidr}"
 availability_zone = "us-east-1b"
 map_public_ip_on_launch = false 
}
#Bastion remove
resource "aws_subnet" "public-subnet-1" {
 vpc_id = aws_vpc.vpc.id
 cidr_block = "${var.public-subnet-3-cidr}"
 availability_zone = "us-east-1b"
 map_public_ip_on_launch = true 
}
resource "aws_route_table" "public-route-table" {
  vpc_id       = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"     
    gateway_id = aws_internet_gateway.internet-gateway.id
  }

}

resource "aws_default_route_table" "ex_private_rt" {
  default_route_table_id  = "${aws_vpc.vpc.default_route_table_id}"

}

# Associate Public Subnet 1 to "Public Route Table"
# terraform aws associate subnet with route table
resource "aws_route_table_association" "public-subnet-1-route-table-association" {
  subnet_id           = aws_subnet.public-subnet-1.id
  route_table_id      = aws_route_table.public-route-table.id
}

