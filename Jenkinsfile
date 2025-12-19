pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git url: 'YOUR_REPO_URL_HERE'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh 'docker build -t my-app:latest .'
                }
            }
        }

        stage('Run Container') {
            steps {
                script {
                    sh 'docker run -d --name test-app -p 8081:8081 my-app:latest'
                }
            }
        }

        stage('Cleanup') {
            steps {
                script {
                    sh 'docker stop test-app || true'
                    sh 'docker rm test-app || true'
                }
            }
        }
    }
}