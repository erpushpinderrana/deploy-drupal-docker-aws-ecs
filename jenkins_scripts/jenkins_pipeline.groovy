pipeline {
  environment {
    registry = "pushpinderdocker/apache-php"
    registryCredential = 'pushpinderdocker'
  }
  agent any
  stages {
    stage('Cloning Git') {
      steps {
        git 'https://github.com/erpushpinderrana/deploy-drupal-docker-aws-ecs.git'
      }
    }
    stage('Building image') {
      steps {
        script {
          dockerImage = docker.build registry + ":$BUILD_NUMBER"
        }
      }
    }
    stage('Deploy Image') {
      steps {
        script {
          docker.withRegistry('', registryCredential) {
            dockerImage.push()
          }
        }
      }
    }
    stage('Remove Unused docker image') {
      steps {
        sh "docker rmi $registry:$BUILD_NUMBER"
      }
    }
  }
}