provider "aws" {
  region = "us-east-1"
  access_key = "AXXXXXXXXXXXXXXXXXXXP"
  secret_key = "xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX8"
}

module "ecs" {
  source = "./modules/ecs"

  environment          = var.environment
  cluster              = var.environment
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones   = var.availability_zones
  max_size             = var.max_size
  min_size             = var.min_size
  desired_capacity     = var.desired_capacity
  instance_type        = var.instance_type
  ecs_aws_ami          = var.ecs_aws_ami
  ecs_ecr              = var.ecs_ecr
  ecs_task_definition  = var.ecs_task_definition
  ecs_service          = var.ecs_service
}

variable "vpc_cidr" {}
variable "environment" {}
variable "max_size" {}
variable "min_size" {}
variable "desired_capacity" {}
variable "instance_type" {}
variable "ecs_aws_ami" {}
variable "ecs_ecr" {}
variable "ecs_task_definition" {}
variable "ecs_service" {}

variable "private_subnet_cidrs" {
  type = list
}

variable "public_subnet_cidrs" {
  type = list
}

variable "availability_zones" {
  type = list
}

