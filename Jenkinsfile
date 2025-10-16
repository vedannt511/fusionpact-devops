pipeline {
    agent any

    stages {
        stage('Git Checkout') {
            steps {
                git branch: 'main', credentialsId: 'github', url: 'https://github.com/vedannt511/fusionpact-devops.git'
            }
        }

        stage('Install Dependencies & Test Backend') {
            steps {
                dir('backend') {
                    sh '''
                    python3 -m venv venv
                    . venv/bin/activate
                    pip install --upgrade pip
                    pip install -r requirements.txt
                    '''
                }
            }
        }

        stage('Build Docker Images') {
            steps {
                script {
                    sh "docker build -t vedant511/fusionpact-backend:latest ./backend"
                    sh "docker build -t vedant511/fusionpact-frontend:latest ./frontend"
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    withDockerRegistry(credentialsId: 'dockerhub') {
                        sh "docker push vedant511/fusionpact-backend:latest"
                        sh "docker push vedant511/fusionpact-frontend:latest"
                    }
                }
            }
        }

        stage('Docker Compose Up') {
            steps {
                // Assuming docker-compose.yml is at workspace root
                sh 'docker-compose down -v || true' // stop and remove old containers and volumes
                sh 'docker-compose up -d --build'
            }
        }
    }

  
}
