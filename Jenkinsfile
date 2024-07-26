pipeline {
    agent any

    stages {
        stage('Build Docker Image') {
            steps {
                bat 'docker build -t ml-ppl-v1 .'
            }
        }
        stage('Run Docker Container') {
            steps {
                bat 'docker run -d --name ml-cicd-v1 -p 8888:8888 ml-ppl-v1'
            }
        }
        stage('Run Preprocessing') {
            steps {
                bat 'winpty docker exec -it ml-cicd-v1 python preprocessing.py'
            }
        }
        stage('Run Training') {
            steps {
                bat 'winpty docker exec -it ml-cicd-v1 python train.py'
            }
        }
        stage('Run Testing') {
            steps {
                bat 'winpty docker exec -it ml-cicd-v1 python test.py'
            }
        }
    }
}