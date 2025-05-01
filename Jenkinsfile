pipeline {
    agent any

    tools {
        nodejs 'node-18'  // Ensure 'node-18' is configured in Jenkins tools
    }

    environment {
        IMAGE_NAME = 'car-rental-app'
        CONTAINER_NAME = 'car-rental-container'
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/ayushsrivastav119/carRental.git'
            }
        }

        stage('Install Dependencies') {
            steps {
                sh 'npm install'
            }
        }

        stage('Build React App') {
            steps {
                sh 'CI=false npm run build'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    dockerImage = docker.build("${IMAGE_NAME}")
                }
            }
        }

        stage('Stop and Remove Old Container') {
            steps {
                sh "docker rm -f ${CONTAINER_NAME} || true"
            }
        }

        stage('Run New Docker Container') {
            steps {
                sh "docker run -d --name ${CONTAINER_NAME} -p 3000:80 ${IMAGE_NAME}"
            }
        }
    }

    post {
        success {
            echo "✅ Deployment complete!"
        }
        failure {
            echo "❌ Build failed!"
        }
    }
}
