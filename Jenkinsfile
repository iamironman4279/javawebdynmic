pipeline {
    agent any

    environment {
        IMAGE_NAME = 'bankapp-tomcat'    // Update with your desired image name
    }

    stages {
        stage('Checkout') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: 'main']], 
                          userRemoteConfigs: [[url: 'https://github.com/iamironman4279/javawebdynmic.git']]
                ])
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build Docker image
                    sh "docker build -t ${IMAGE_NAME}:${env.BUILD_NUMBER} ."
                }
            }
        }

        stage('Finalize') {
            steps {
                script {
                    try {
                        // Print Docker container status
                        sh "docker ps -a"
                    } catch (Exception e) {
                        echo "Error in final stage: ${e.getMessage()}"
                    } finally {
                        // Clean up Docker containers
                        sh "docker rm -f \$(docker ps -a -q)"
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
