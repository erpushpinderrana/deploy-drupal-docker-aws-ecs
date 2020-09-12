node {
  stage('Clone repository') {
    git branch: "master", url: "https://github.com/erpushpinderrana/deploy-drupal-docker-aws-ecs.git", credentialsId: "12345678-40df-496e-ba81-017970ec033c"
  }
  stage('Build image') {
    sh "docker build -t 000xxxxxx107.dkr.ecr.us-east-2.amazonaws.com/aws-drupal-ecr:v_'$BUILD_NUMBER' ."
  }
  stage('Push image') {
    docker.withRegistry('https://000xxxxxx107.dkr.ecr.us-east-2.amazonaws.com', 'ecr:us-east-2:erpushpinder-ecr-user') {
      sh "docker push 000xxxxxx107.dkr.ecr.us-east-2.amazonaws.com/aws-drupal-ecr:v_'$BUILD_NUMBER'"
    }
  }
  stage('Run service') {
    sh "bash ./aws_scripts/service.sh"
  }
}