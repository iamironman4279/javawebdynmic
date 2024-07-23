pipeline {
    agent any

    environment {
        // Define environment variables if needed
        JAVA_HOME = '/usr/lib/jvm/java-11-openjdk'
    }

    stages {
        stage('Checkout') {
            steps {
                script {
                    // Checkout code from GitHub
                    checkout([$class: 'GitSCM', 
                              branches: [[name: '*/main']], 
                              userRemoteConfigs: [[url: 'https://github.com/iamironman4279/javawebdynmic.git']]
                    ])
                }
            }
        }

        stage('Build') {
            steps {
                script {
                    // Build the Java application
                    sh './mvnw clean package' // Use this if you're using Maven Wrapper
                    // sh 'mvn clean package' // Use this if you have Maven installed locally
                }
            }
        }

        stage('Test') {
            steps {
                script {
                    // Run tests
                    sh './mvnw test' // Use this if you're using Maven Wrapper
                    // sh 'mvn test' // Use this if you have Maven installed locally
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    // Deploy the application
                    echo 'Deploying to server...'
                    // Add deployment commands here, e.g., `sh './deploy.sh'`
                }
            }
        }
    }

    post {
        always {
            // Actions to always execute after the pipeline
            echo 'Cleaning up...'
        }
        success {
            // Actions to execute on successful build
            echo 'Build succeeded!'
        }
        failure {
            // Actions to execute on failed build
            echo 'Build failed.'
        }
    }
}
