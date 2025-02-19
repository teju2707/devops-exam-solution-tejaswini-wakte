pipeline {
    agent any
    environment {
        AWS_REGION = 'ap-south-1'
        S3_BUCKET = '467.devops.candidate.exam'
        S3_KEY = 'Tejaswini.wakte'
    }
    stages {
        stage('TF Init') {
            steps {
                script {
                    sh 'terraform init -backend-config="bucket=${S3_BUCKET}" -backend-config="key=${S3_KEY}" -backend-config="region=${AWS_REGION}"'
                }
            }
        }
        stage('TF Validate') {
            steps {
                script {
                    sh 'terraform validate'
                }
            }
        }
        stage('TF Plan') {
            steps {
                script {
                    sh 'terraform plan'
                }
            }
        }
        stage('TF Apply') {
            steps {
                script {
                    sh 'terraform apply -auto-approve'
                }
            }
        }
        stage('Invoke Lambda') {
            steps {
                script {
                    def invoke_command = "aws lambda invoke --function-name api_invoker --log-type Tail --query 'LogResult' --output text response.json | base64 -d"
                    def response = sh(script: invoke_command, returnStdout: true).trim()
                    echo "Lambda Response: ${response}"
                }
            }
        }
    }
}
