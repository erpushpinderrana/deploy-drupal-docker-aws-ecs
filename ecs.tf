provider "aws" {
  region = "us-east-1"
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
  key_name             = aws_key_pair.ecs.key_name
  instance_type        = var.instance_type
  ecs_aws_ami          = var.ecs_aws_ami
}

resource "aws_key_pair" "ecs" {
  key_name   = "ecs-key-${var.environment}"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDdQXYrnFXb58MMtpGTKkf2R3J+rH2zu3LDjxZBuZGfZr403LW+BEkL96angVlH6Q/4Vz0an6CC9KE9oFJuckTEgQfM2FXKZyWURlo2ngBbU30cODtp2qvPHBUa0LfiNVwmAA3VYNVDugs7ES6IMHtddCpkS7HliQSbYDH+A1Rwl+335fVdSvHgpIKfC0xe8mDc1j7Ba8k58g8I/vc0JmZ7X9IUJQcPmNpmPhHglSdnfdKdBE0G+RJ/0kGaw6G+qQahN7qdW7AsDH+x5qqflS2Rn5O0RaAw5MWW19PSHCL+EK8oE6M7CgnVgYIEbIw+IRKtfvrbS7nGpvFqx9rNqE4SwJ19SGIEGQOJGv7xqnqRQxA6fSvTmPCypEXHQX5Hc7Yq0BVxrIakNrm31OEE0orauC7IO72/XC1fm5vibh+LI3U5QjZLfCU5+1hP2rGiRw9Gacz/6Q4aTcsLSO6+w9zY0iG9XoWynyXwD6mEAJBzdmyGPgzl3wm8VbtfvkLGvl/8MmQvlkpwjB+puo3qbafdSfaUNQCe89kRuz/En3DQwasLpm8ERUvL88Iy1SsDsel8O3r1F8UF2k5tRK8faHhuW8UVStcO2flVavCUFpxFtb81HSSt"
}

variable "vpc_cidr" {}
variable "environment" {}
variable "max_size" {}
variable "min_size" {}
variable "desired_capacity" {}
variable "instance_type" {}
variable "ecs_aws_ami" {}

variable "private_subnet_cidrs" {
  type = list
}

variable "public_subnet_cidrs" {
  type = list
}

variable "availability_zones" {
  type = list
}

