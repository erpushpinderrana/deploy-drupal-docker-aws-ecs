module "vpc" {
  source = "../vpc"

  cidr        = var.vpc_cidr
  environment = var.environment
}

module "private_subnet" {
  source = "../subnet"

  name               = "${var.environment}_private_subnet"
  environment        = var.environment
  vpc_id             = module.vpc.id
  cidrs              = var.private_subnet_cidrs
  availability_zones = var.availability_zones
}

module "public_subnet" {
  source = "../subnet"

  name               = "${var.environment}_public_subnet"
  environment        = var.environment
  vpc_id             = module.vpc.id
  cidrs              = var.public_subnet_cidrs
  availability_zones = var.availability_zones
}
