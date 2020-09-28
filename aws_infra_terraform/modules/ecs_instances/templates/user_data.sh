#!/bin/bash

#Using script from http://docs.aws.amazon.com/AmazonECS/latest/developerguide/using_cloudwatch_logs.html
# Install awslogs and the jq JSON parser
yum install -y awslogs jq aws-cli

# ECS config
${ecs_config}
{
  echo "ECS_CLUSTER=${cluster_name}"
  echo 'ECS_AVAILABLE_LOGGING_DRIVERS=${ecs_logging}'
} >> /etc/ecs/ecs.config

start ecs

echo "Done"
