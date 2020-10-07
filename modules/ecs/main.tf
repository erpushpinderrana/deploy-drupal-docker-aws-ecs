module "network" {
  source               = "../network"
  environment          = var.environment
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones   = var.availability_zones
}

module "ecs_instances" {
  source = "../ecs_instances"

  environment             = var.environment
  cluster                 = var.cluster
  instance_group          = var.instance_group
  private_subnet_ids      = module.network.private_subnet_ids
  aws_ami                 = var.ecs_aws_ami
  instance_type           = var.instance_type
  max_size                = var.max_size
  min_size                = var.min_size
  desired_capacity        = var.desired_capacity
  vpc_id                  = module.network.vpc_id
  iam_instance_profile_id = aws_iam_instance_profile.ecs.id
}

resource "aws_ecs_cluster" "cluster" {
  name = var.cluster
}

resource "aws_ecr_repository" "ecr_repo" {
  name = var.ecs_ecr
}

resource "aws_ecr_repository_policy" "ecr_repo_policy" {
  repository = aws_ecr_repository.ecr_repo.name

  policy = <<EOF
{
    "Version": "2008-10-17",
    "Statement": [
        {
            "Sid": "new policy",
            "Effect": "Allow",
            "Principal": "*",
            "Action": [
                "ecr:GetDownloadUrlForLayer",
                "ecr:BatchGetImage",
                "ecr:BatchCheckLayerAvailability",
                "ecr:PutImage",
                "ecr:InitiateLayerUpload",
                "ecr:UploadLayerPart",
                "ecr:CompleteLayerUpload",
                "ecr:DescribeRepositories",
                "ecr:GetRepositoryPolicy",
                "ecr:ListImages",
                "ecr:DeleteRepository",
                "ecr:BatchDeleteImage",
                "ecr:SetRepositoryPolicy",
                "ecr:DeleteRepositoryPolicy"
            ]
        }
    ]
}
EOF
}

resource "aws_ecs_task_definition" "ecs_task_definition" {
  family                = var.ecs_task_definition
  container_definitions = <<TASK_DEFINITION
[
    {
        "cpu": 10,
        "command": ["sleep", "10"],
        "entryPoint": ["/"],
        "environment": [
            {"name": "VARNAME", "value": "VARVAL"}
        ],
        "essential": true,
        "image": "nginx",
        "memory": 128,
        "name": "jenkins",
        "portMappings": [
            {
                "containerPort": 80,
                "hostPort": 8080
            }
        ],
        "resourceRequirements":[
            {
                "type":"InferenceAccelerator",
                "value":"device_1"
            }
        ]
    }
]
TASK_DEFINITION

  inference_accelerator {
    device_name = "device_1"
    device_type = "eia1.medium"
  }
}

resource "aws_ecs_service" "ecs_service" {
  name            = var.ecs_service
  cluster         = aws_ecs_cluster.cluster.id
  task_definition = aws_ecs_task_definition.ecs_task_definition.arn
  desired_count   = var.desired_capacity
  depends_on      = [aws_iam_role_policy_attachment.ecs_ec2_role]

  ordered_placement_strategy {
    type  = "binpack"
    field = "cpu"
  }

  placement_constraints {
    type       = "memberOf"
    expression = "attribute:ecs.availability-zone in [us-east-1a]"
  }
}
