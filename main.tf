terraform {
  backend "s3" {
    bucket = "terraform-state-falcon8983"
    key    = "global/project2/terraform.tfstate"
    region = "ap-south-1"
    dynamodb_table = "terraform-state-locking"
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