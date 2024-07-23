pipeline {
    agent any

    environment {
        KUBERNETES_CONFIG = 'kubernetes-deployment.yaml'
        KUBE_CREDENTIALS_ID = '1234' // ID of your Kubernetes credentials in Jenkins
    }

    stages {
        stage('Checkout') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: 'main']], 
                          userRemoteConfigs: [[url: 'https://github.com/iamironman4279/javawebdynmic.git']]
                ])
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                withCredentials([kubeconfigFile(credentialsId: KUBE_CREDENTIALS_ID, variable: 'KUBECONFIG')]) {
                    script {
                        // Apply Kubernetes deployment configuration
                        sh "kubectl apply -f ${KUBERNETES_CONFIG}"
                    }
                }
            }
        }

        stage('Verify Deployment') {
            steps {
                withCredentials([kubeconfigFile(credentialsId: KUBE_CREDENTIALS_ID, variable: 'KUBECONFIG')]) {
                    script {
                        // Verify the status of the pods
                        sh "kubectl get pods"
                        
                        // Optionally, you can add more checks, like services or deployments
                        sh "kubectl get svc"
                        sh "kubectl get deployments"
                    }
                }
            }
        }
    }

    post {
        success {
            echo "Deployment completed successfully."
        }
        failure {
            echo "Deployment failed."
        }
    }
}
