variable "region" {
  default = "eu-west-2"
  description = "Aws region"
}

variable "new_test_vpc-cidr_block" {
  default = "10.0.0.0/16"
  description = "new_test_vpc-cidr-block"
}

variable "new_test_pub_subnet1-cidr_block" {
  default = "10.0.1.0/24"
  description = "new_test_pub_subnet1-cidr_block"
}

variable "new_test_pub_subnet2-cidr_block" {
  default = "10.0.2.0/24"
  description = "new_test_pub_subnet2-cidr_block"
}

variable "new_test_priv_subnet1-cidr_block" {
  default = "10.0.3.0/24"
  description = "new_test_priv_subnet1-cidr_block"
}

variable "new_test_priv_subnet2-cidr_block" {
  default = "10.0.4.0/24"
  description = "new_test_priv_subnet2-cidr_block"
}


variable "test1_ec2_sg-aws_security_group" {
  default = "allow access to port 80"
  description = "test1_ec2_sg-aws_security_group"
}

variable "test2_ec2_sg-aws_security_group" {
  default = "allow access to port 22"
  description = "test2_ec2_sg-aws_security_group"
}

variable "test1_ec2_instance-aws_instance" {
  default = "ami-0f540e9f488cfa27d"
  description = "test1_ec2_instance"
}

variable "test2_ec2_instance-aws_instance" {
  default = "ami-0f540e9f488cfa27d"
  description = "test2_ec2_instance"
}
