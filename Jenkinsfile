pipeline {
    agent any

    environment {
        IMAGE_NAME = 'bankapp-tomcat'
        DOCKER_REPO = 'hemanth42079/bankapp-tomcat'
        DOCKER_TAG = 'latest'
        KUBERNETES_CONFIG = 'kubernetes-deployment.yaml'
        KUBE_CREDENTIALS_ID = '1234' // ID for Secret text credentials
    }

    stages {
        stage('Checkout') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: 'main']], 
                          userRemoteConfigs: [[url: 'https://github.com/iamironman4279/javawebdynmic.git']]
                ])
            }
        }

        stage('Pull Docker Image') {
            steps {
                script {
                    sh "docker pull ${DOCKER_REPO}:${DOCKER_TAG}"
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                script {
                    sh "docker rm -f bankapp_container || true"
                    sh "docker run -d -p 80:8080 --name bankapp_container ${DOCKER_REPO}:${DOCKER_TAG}"
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                withCredentials([string(credentialsId: KUBE_CREDENTIALS_ID, variable: 'KUBE_SECRET')]) {
                    script {
                        // Use the secret text directly
                        sh "echo ${KUBE_SECRET} > /tmp/kubeconfig"
                        sh "kubectl --kubeconfig=/tmp/kubeconfig apply -f ${KUBERNETES_CONFIG}"
                    }
                }
            }
        }

        stage('Verify Deployment') {
            steps {
                withCredentials([string(credentialsId: KUBE_CREDENTIALS_ID, variable: 'KUBE_SECRET')]) {
                    script {
                        // Use the secret text directly
                        sh "echo ${KUBE_SECRET} > /tmp/kubeconfig"
                        sh "kubectl --kubeconfig=/tmp/kubeconfig get pods"
                    }
                }
            }
        }
    }

    post {
        success {
            echo "Pipeline completed successfully."
        }
        failure {
            echo "Pipeline failed."
        }
    }
}
