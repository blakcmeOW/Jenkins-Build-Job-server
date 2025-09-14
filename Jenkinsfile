pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                git branch: 'main',
                    credentialsId: '<your-credentials-id>',
                    url: '<your-repo-url>'
            }
        }
        stage('Terraform Init') {
            steps {
                sh 'terraform init'
            }
        }
        stage('Terraform Plan') {
            steps {
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: '<your-aws-credentials-id>',
                    accessKeyVariable: '<AWS_ACCESS_KEY_ID>',
                    secretKeyVariable: '<AWS_SECRET_ACCESS_KEY>'
                ]]) {
                    sh 'terraform plan -out=tfplan'
                }
            }
        }
        stage('Terraform Apply') {
            steps {
                input message: 'Approve Terraform plan?', ok: 'Apply'
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: '<your-aws-credentials-id>',
                    accessKeyVariable: '<AWS_ACCESS_KEY_ID>',
                    secretKeyVariable: '<AWS_SECRET_ACCESS_KEY>'
                ]]) {
                    sh 'terraform apply -auto-approve tfplan'
                }
            }
        }
    }
    post {
        always {
            cleanWs()
        }
        success {
            echo 'Terraform deployment completed successfully!'
        }
        failure {
            echo 'Terraform deployment failed.'
        }
    }
}
