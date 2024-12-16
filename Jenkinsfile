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

        stage('Cleanup Existing Resources') {
            steps {
                script {
                    sh '''
                        docker ps -q --filter "publish=5000" | xargs -r docker stop
                        docker ps -a -q --filter "publish=5000" | xargs -r docker rm
                        '''
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
            mail to: 'abdelkhalek.saadani@insat.ucar.tn',
             subject: "SUCCESS: ${env.JOB_NAME} #${env.BUILD_NUMBER}",
             body: "The build ${env.BUILD_NUMBER} completed successfully.\nCheck details: <a href='${env.BUILD_URL}'>${env.BUILD_URL}</a>"
        }
        failure {
            echo "Deployment failed. Please check the logs."
            mail to: 'abdelkhalek.saadani@insat.ucar.tn',
             subject: "FAILURE: ${env.JOB_NAME} #${env.BUILD_NUMBER}",
             body: "The build ${env.BUILD_NUMBER} failed.\nCheck details: <a href='${env.BUILD_URL}'>${env.BUILD_URL}</a>"
        }
        always {
            echo "Pipeline execution completed."
        }
    }
}