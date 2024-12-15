pipeline {
    agent any
    
    environment {
        APP_VERSION = "v1.0.${BUILD_NUMBER}"
        DOCKER_IMAGE = "webapp"
    }
    
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        
        stage('Build App') {
            steps {
                dir('app') {
                    sh 'docker build -t ${DOCKER_IMAGE}:${APP_VERSION} .'
                }
            }
        }
        
        stage('Terraform Init') {
            steps {
                dir('terraform') {
                    sh 'terraform init'
                }
            }
        }
        
        stage('Terraform Plan') {
            steps {
                dir('terraform') {
                    sh "terraform plan -var='app_version=${APP_VERSION}'"
                }
            }
        }
        
        stage('Terraform Apply') {
            steps {
                dir('terraform') {
                    sh "terraform apply -auto-approve -var='app_version=${APP_VERSION}'"
                }
            }
        }
    }
    
    post {
        success {
            echo "Deployment successful! Application version ${APP_VERSION} is now running."
        }
        failure {
            echo "Deployment failed. Please check the logs."
        }
        always {
            echo "Pipeline execution completed."
        }
    }
}