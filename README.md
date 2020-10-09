# Create basic AWS resources using Terraform. 
WIP

## Prerequisites

1. [Terraform](https://www.terraform.io/downloads.html)
2. [AWS Console](https://aws.amazon.com/)

Note: Update the AWS access and secret keys in [ecs.tf](https://github.com/erpushpinderrana/deploy-drupal-docker-aws-ecs/blob/aws-ecs-immutable/ecs.tf) file.

## Quick Setup
Clone this repository and run the below command:
* ``terraform init -input=false -var-file=ecs.tfvars`` To initialize a working directory containing Terraform configuration files.
* ``terraform plan -input=false -var-file=ecs.tfvars`` Create an execution plan.
* ``terraform apply -input=false -var-file=ecs.tfvars`` To apply the changes required to reach the desired state of the configuration.

If it runs successfully, then it will create the below resources in your AWS console:

* Cluster
![ECS Cluster](https://github.com/erpushpinderrana/files/blob/master/Cluster.png)

* ECR
![ECR](https://github.com/erpushpinderrana/files/blob/master/ECR.png)

* EC2 Instance
![EC2](https://github.com/erpushpinderrana/files/blob/master/EC2_instance.png)

* Auto Scaling Group
![ASG](https://github.com/erpushpinderrana/files/blob/master/ASG.png)

* ECS Task Definition
![Task Definition](https://github.com/erpushpinderrana/files/blob/master/ECS%20Task%20Def.png)

* AWS ECS Roles
![AWS ECS Roles](https://github.com/erpushpinderrana/files/blob/master/AWS%20ECS%20Roles.png)

## Using Jenkins
In case, if you need to setup it using Jenkins then you should follow the instructions in [Jenkins Setup](https://github.com/erpushpinderrana/jenkins-terraform-aws/tree/master/jenkins_scripts).

## References
* https://github.com/erpushpinderrana/terraform-ecs
