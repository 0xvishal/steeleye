# Define AWS as our provider
provider "aws" {
  region = "ap-south-1"
}


resource "aws_key_pair" "deployer" {
  key_name   = "steeleye"
  public_key = "PROVIDE YOUR PUBLIC KEY HERE"
}

variable "private-subnet1" {
  description = "Private subnet of default VPC"
  default = "subnet-f5hjbtw3"
}

variable "private-subnet2" {
  description = "Private subnet of default VPC"
  default = "subnet-s3fdrt6h"
}

variable "vpc" {
  description = "Default VPC"
  default = "vpc-rj6zp4l"
}

variable "ami" {
 description = "AMI for application servers"
 default = "ami-073c8c0760395aab8"
}
