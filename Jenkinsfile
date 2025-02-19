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
    post {
        success {
            emailext (
                to: 'jawaleteju@gmail.com',
                subject: "Build Success - ${env.JOB_NAME} Build #${env.BUILD_NUMBER}",
                body: "Good news! Your build succeeded.\n\nCheck console output at ${env.BUILD_URL} to view the results."
            )
        }
        failure {
            emailext (
                to: 'jawaleteju@gmail.com',
                subject: "Build Failed - ${env.JOB_NAME} Build #${env.BUILD_NUMBER}",
                body: "Unfortunately, your build failed.\n\nCheck console output at ${env.BUILD_URL} to view the results."
            )
        }
    }
}
