#!/bin/bash
# BUILD_NUMBER=3
SERVICE_NAME="aws-ecs-service"
IMAGE_VERSION="v_"${BUILD_NUMBER}
TASK_FAMILY="aws-apache-php-def"

# Create a new task definition for this build
sed -e "s;%BUILD_NUMBER%;${BUILD_NUMBER};g" aws-apache-php-def.json > aws-apache-php-def-v_${BUILD_NUMBER}.json
aws ecs register-task-definition --family aws-apache-php-def.json --cli-input-json file://aws-apache-php-def-v_${BUILD_NUMBER}.json

# Update the service with the new task definition and desired count
TASK_REVISION=`aws ecs describe-task-definition --task-definition aws-apache-php-def | egrep "revision" | tr "/" " " | awk '{print $2}' | sed 's/,$//'`
DESIRED_COUNT=`aws ecs describe-services --services ${SERVICE_NAME} | egrep "desiredCount" | tr "/" " " | awk '{print $2}' | sed 's/,$//'`
if [ "$DESIRED_COUNT" = "0" ]; then
    DESIRED_COUNT="1"
fi

# Update the service in AWS with new task definition revision
aws ecs update-service --cluster aws-ecs-poc --region us-east-2 --service ${SERVICE_NAME} --task-definition ${TASK_FAMILY}:${TASK_REVISION} --desired-count ${DESIRED_COUNT}

# Update the service by managing parameters in a separate file, equivalent to above command.
#sed -e "s;%TASK_NUMBER%;${TASK_FAMILY}:${TASK_REVISION};g" service-update.json > service-update-${TASK_REVISION}.json
#aws ecs update-service --cli-input-json file://service-update-${TASK_REVISION}.json
