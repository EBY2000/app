pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/EBY2000/app.git', branch: 'main'
            }
        }

        stage('Run Tests') {
            steps {
                script {
                    // Собираем образ с тестами
                    sh 'docker build -t my-app-test .'
                    // Запускаем pytest внутри контейнера
                    sh 'docker run --rm my-app-test pytest test_app.py'
                }
            }
        }

        stage('Build Docker Image!') {
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
