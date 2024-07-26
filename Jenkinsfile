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
                bat 'docker rm -f ml-cicd-v1 || true'
                bat 'docker run -d --name ml-cicd-v1 -p 8888:8888 ml-ppl-v1'
            }
        }
        stage('Run Preprocessing') {
            steps {
                bat 'docker exec ml-cicd-v1 python preprocessing.py'
            }
        }
        stage('Run Training') {
            steps {
                bat 'docker exec ml-cicd-v1 python train.py'
            }
        }
        stage('Run Testing') {
            steps {
                bat 'docker exec ml-cicd-v1 python test.py'
            }
        }
        stage('Export Session Token') {
            steps {
                bat 'docker exec ml-cicd-v1 bash -c "echo \$SESSION_TOKEN > /tmp/session_token.txt"'
                bat "docker cp ml-cicd-v1:/tmp/session_token.txt ${WORKSPACE}/session_token.txt"
                script {
                    def sessionToken = readFile("${WORKSPACE}/session_token.txt").trim()
                    env.SESSION_TOKEN = sessionToken
                    println "Session Token: ${SESSION_TOKEN}"
                }
            }
        }
    }
}