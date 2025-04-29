pipeline {
  agent any

  tools {
    nodejs 'node-18'  // Must match what you configured in Jenkins
  }

  environment {
    IMAGE_NAME = 'car-rental-app'
    CONTAINER_NAME = 'car-rental-container'
  }

  stages {
    stage('Clone Repo') {
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
        // Disable CI mode to allow warnings
        sh 'CI=false npm run build'
      }
    }

    stage('Build Docker Image') {
      steps {
        sh 'docker build -t $IMAGE_NAME .'
      }
    }

    stage('Stop Old Container') {
      steps {
        sh 'docker rm -f $CONTAINER_NAME || true'
      }
    }

    stage('Run New Container') {
      steps {
        sh 'docker run -d --name $CONTAINER_NAME -p 3000:80 $IMAGE_NAME'
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
