# Deploy a basic PHP Drupal Docker Container on AWS ECS
WIP

## Prerequisites
* Install the [Jenkins](https://www.jenkins.io/download/). We should install [docker](https://docs.docker.com/get-docker/) and [AWS CLI](https://aws.amazon.com/) in Jenkins instance or you may setup the Jenkins by following the instructions in [Jenkins Setup](https://github.com/erpushpinderrana/jenkins-terraform-aws/tree/master/jenkins_scripts) repository.
* Install the required plugins such as Docker Pipeline, Amazon ECR and CloudBees AWS Credentials Plugins.
* Configure your aws credentials in jenkins account using `aws configure` command.

## Quick Setup
1. Clone this repository.
2. Create a Pipeline job in Jenkins and put the [groovy](https://github.com/erpushpinderrana/deploy-drupal-docker-aws-ecs/blob/aws-jenkins-ecs-deployment/jenkins_pipeline.groovy) script code and update the parameters with your AWS configurations.
3. Save the job.
4. Run build.
