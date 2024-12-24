provider "aws" {
    region = var.region
  }
module "vpc" {
  source = "./modules/vpc"  

  region          = var.region
  vpc_cidr        = var.vpc_cidr
  name            = var.name
  az1             = var.az1
  pri_sub_cidr    = var.pri_sub_cidr
  pub_sub_cidr    = var.pub_sub_cidr
  env             = var.env
}
