terraform {
  backend "s3" {
    bucket = "your-bucket-name"
    key    = "location/where/to/store"
    region = "ap-south-1"
    dynamodb_table = "your-dynamodb-table-name"
    encrypt = true
  }
}



module "vpc_networking" {
  source = "./vpc_networking"
  vpc_cidr_block = var.vpc_cidr_block
  public_subnet_1_cidr = var.public_subnet_1_cidr
  
  
  ec2_instance_type = var.ec2_instance_type
  ec2_keypair = var.ec2_keypair
}