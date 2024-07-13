pipeline {
    agent any

    environment {
        DOCKER_COMPOSE_VERSION = '1.29.2'
        IMAGE_NAME = 'bankapp-tomcat'
        APP_PORT = '8082'
        SUDO_CREDENTIALS = credentials('my-sudo-credentials') // Replace with your actual Jenkins credential ID
    }

    stages {
        stage('Checkout') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: 'main']], 
                          userRemoteConfigs: [[url: 'https://github.com/iamironman4279/javawebdynmic.git']]
                ])
            }
        }

        stage('Install Dependencies') {
            steps {
                script {
                    // Switch to root user with sudo su and run subsequent commands
                    sh "echo ${SUDO_CREDENTIALS} | sudo -S su -"
                    sh "apt update"
                    sh "apt install -y python3-pip"
                    sh "pip3 install docker-compose==${DOCKER_COMPOSE_VERSION}"
                }
            }
        }

        stage('Build Docker Images') {
            steps {
                script {
                    sh "docker build -t ${IMAGE_NAME}:7 ."
                }
            }
        }

        stage('Setup Docker Network') {
            steps {
                script {
                    sh "docker network create bankapp-network"
                }
            }
        }

        stage('Deploy Docker Containers') {
            steps {
                script {
                    sh "docker-compose -f docker-compose.yml up -d --build"
                }
            }
        }

        stage('Finalize') {
            steps {
                echo "Final cleanup or notifications can go here"
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
