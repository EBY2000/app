pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/EBY2000/app.git', branch: 'main'
                pip install pytest
            }
        }


        stage('Run Test') {
            steps {
                script {
                    sh 'pytest test_app.py'
                }
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
                    sh 'docker run -d --name test-app -p 8080:8080 my-app:latest'
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

    post {
        success {
            echo "Build succeeded 🎉"
        }
        failure {
            echo "Build failed ❌"
        }
    }
}
