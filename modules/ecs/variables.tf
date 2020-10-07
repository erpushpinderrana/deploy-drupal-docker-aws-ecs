variable "environment" {
  description = "Dev environment"
}

variable "cluster" {
  default     = "default"
  description = "The name of the ECS cluster"
}

variable "instance_group" {
  default     = "default"
  description = "The name of the instances that you consider as a group"
}

variable "vpc_cidr" {
  description = "VPC cidr block. Example: 10.0.0.0/16"
}

variable "private_subnet_cidrs" {
  type        = list
  description = "List of private cidrs, for every avalibility zone you want you need one. Example: 10.0.0.0/24 and 10.0.1.0/24"
}

variable "public_subnet_cidrs" {
  type        = list
  description = "List of public cidrs, for every avalibility zone you want you need one. Example: 10.0.0.0/24 and 10.0.1.0/24"
}

variable "load_balancers" {
  type        = list
  default     = []
  description = "The load balancers to couple to the instances"
}

variable "availability_zones" {
  type        = list
  description = "List of avalibility zones you want. Example: eu-west-1a and eu-west-1b"
}

variable "max_size" {
  description = "Maximum size of the nodes in the cluster"
}

variable "min_size" {
  description = "Minimum size of the nodes in the cluster"
}

variable "desired_capacity" {
  description = "The desired capacity of the cluster"
}

variable "instance_type" {
  description = "AWS instance type to use"
}

variable "ecs_aws_ami" {
  description = "The AWS ami id to use for ECS"
}

variable "ecs_config" {
  default     = "echo '' > /etc/ecs/ecs.config"
  description = "Specify ecs configuration or get it from S3. Example: aws s3 cp s3://some-bucket/ecs.config /etc/ecs/ecs.config"
}

variable "ecs_service" {
  default = "ECS Service"
}

variable "ecs_task_definition" {
  default = "ECS Task Definition"
}

variable "ecs_ecr" {
  default = "ECR Repository"
}
