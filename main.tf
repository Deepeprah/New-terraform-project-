# creat a vpc
resource "aws_vpc" "new_test_vpc" {
  cidr_block       = var.new_test_vpc-cidr_block
  instance_tenancy = "default"
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
    Name = "new_test_vpc"
  }
}

# create internet gateway and attach to vpc 
resource "aws_internet_gateway" "new_test_igw" {
  vpc_id = aws_vpc.new_test_vpc.id

  tags = {
    Name = "new_igw"
  }
}

# creat public subnet1

resource "aws_subnet" "new_test_pub_subnet1" {
  vpc_id     = aws_vpc.new_test_vpc.id
  cidr_block = var.new_test_pub_subnet1-cidr_block
  availability_zone = "eu-west-2a"
  tags = {
    Name = "pub_sub1"
  }
}

# create public subnet 2
resource "aws_subnet" "new_test_pub_subnet2" {
  vpc_id     = aws_vpc.new_test_vpc.id
  cidr_block = var.new_test_pub_subnet2-cidr_block
  availability_zone = "eu-west-2b"

  tags = {
    Name = "pub_sub2"
  }
}

# create private subnet 1
resource "aws_subnet" "new_test_priv_subnet1" {
  vpc_id     = aws_vpc.new_test_vpc.id
  cidr_block = var.new_test_priv_subnet1-cidr_block
  availability_zone = "eu-west-2c"
  tags = {
    Name = "pub_sub3"
  }
}

# create private subnet 2
resource "aws_subnet" "new_test_priv_subnet2" {
  vpc_id     = aws_vpc.new_test_vpc.id
  cidr_block = var.new_test_priv_subnet2-cidr_block
  availability_zone = "eu-west-2a"

  tags = {
    Name = "pub_sub2"
  }
}

# create public route table 
resource "aws_route_table" "new_test_pub_rtb" {
  vpc_id = aws_vpc.new_test_vpc.id

  tags = {
    Name = "new_test_pub_rtb"
  }
}

# create private route
resource "aws_route_table" "new_test_priv_rtb" {
  vpc_id = aws_vpc.new_test_vpc.id

  tags = {
    Name = "new_test_priv_rtb"
  }
}

# create route, add internet gateway 
resource "aws_route" "new_test_route" {
  route_table_id            = aws_route_table.new_test_pub_rtb.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id                = aws_internet_gateway.new_test_igw.id
  
}

# associate public route table to public subnet 
resource "aws_route_table_association" "new_test_pub_route_association1" {
  subnet_id      = aws_subnet.new_test_pub_subnet1.id
  route_table_id = aws_route_table.new_test_pub_rtb.id
}

resource "aws_route_table_association" "new_test_pub_route_association2" {
  subnet_id      = aws_subnet.new_test_pub_subnet2.id
  route_table_id = aws_route_table.new_test_pub_rtb.id
}

# associate private route to private subnet 
resource "aws_route_table_association" "new_test_priv_route_association1" {
  subnet_id      = aws_subnet.new_test_priv_subnet1.id
  route_table_id = aws_route_table.new_test_priv_rtb.id
}

# associate private route to private subnet 
resource "aws_route_table_association" "new_test_priv_route_association2" {
  subnet_id      = aws_subnet.new_test_priv_subnet2.id
  route_table_id = aws_route_table.new_test_priv_rtb.id
}


#create eip for nat gateway1
resource "aws_eip" "test_eip1" {
  vpc    = true
  
  tags   ={
    name = "eip1"
  }
}

# create eip for nat gateway2
resource "aws_eip" "test_eip2" {
  vpc    = true
  
  tags   ={
    name = "eip2"
  }
}

# create nat gateway 
resource "aws_nat_gateway" "test_nat_gateway1" {
  allocation_id = aws_eip.test_eip1.id
  subnet_id     = aws_subnet.new_test_priv_subnet1.id

  tags = {
    Name = "new_nat gateway"
  }
}

# create nat gateway 
resource "aws_nat_gateway" "test_nat_gateway2" {
  allocation_id = aws_eip.test_eip2.id
  subnet_id     = aws_subnet.new_test_priv_subnet2.id
  tags = {
    Name = "new_nat gateway"
  }
}


# associate nat gateway with private route table 
resource "aws_route_table_association" "test_nat_gateway1" {
  subnet_id      = aws_subnet.new_test_priv_subnet1.id
  route_table_id = aws_route_table.new_test_priv_rtb.id
}

# associate nat gateway with private route table 
resource "aws_route_table_association" "test_nat_gateway2" {
  subnet_id      = aws_subnet.new_test_priv_subnet2.id
  route_table_id = aws_route_table.new_test_priv_rtb.id
}


#create a security group  inbound 
resource "aws_security_group" "test1_ec2_sg" {
  name               = "ec2 security group"
  description        = var.test1_ec2_sg-aws_security_group
  
  ingress {
    description      = "http access"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "ssh access"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = -1
    cidr_blocks      = ["0.0.0.0/0"]
  }
 tags = {
    name = "new_test_ec2_1_sg"
 }
}


#create a security group  inbound 
resource "aws_security_group" "test2_ec2_sg" {
  name               = "ec2_2_instance"
  ingress {
    description      = "allow http access "
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "allow ssh access"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

tags  = {
 name = "new_test_ec2_2_sg"
}
}


# lunch an ec2 instance 1 using ubuntu ami in a private subnet 
resource "aws_instance" "test1_ec2_instance" {
  ami                    = var.test1_ec2_instance-aws_instance
  tenancy                = "default"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.new_test_priv_subnet1.id
  availability_zone      = "eu-west-2c"

  tags = {
    Name = "new_ec2_instance1"
  }
}


# lunch an ec2 (2) instance using ubuntu ami in a public subnet 
resource "aws_instance" "test2_ec2_instance" {
  ami                    = var.test2_ec2_instance-aws_instance
  instance_type          = "t2.micro"
  tenancy                = "default"
  subnet_id              = aws_subnet.new_test_pub_subnet1.id
  availability_zone      = "eu-west-2a"
  
  tags = {
    Name = "new_ec2_instance2"
  }
}

