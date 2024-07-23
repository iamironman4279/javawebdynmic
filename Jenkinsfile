pipeline {
    agent any
    environment {
        KUBECONFIG = credentials('kubeconfig-id')  // Use Jenkins credentials for kubeconfig
    }
    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/iamironman4279/javawebdynmic.git'
            }
        }
        stage('Build') {
            steps {
                script {
                    // Add your build steps here
                }
            }
        }
        stage('Deploy to Kubernetes') {
            steps {
                script {
                    // Deploy to Kubernetes using kubectl
                    sh 'kubectl apply -f k8s/deployment.yaml'
                    sh 'kubectl apply -f k8s/service.yaml'
                }
            }
        }
        stage('Verify Deployment') {
            steps {
                script {
                    // Verify deployment status
                    sh 'kubectl rollout status deployment/my-deployment'
                }
            }
        }
    }
    post {
        failure {
            echo 'Deployment failed.'
        }
    }
}
