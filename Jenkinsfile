pipeline {
    agent any

    environment {
        FOLDER_NAME = '/home/jovyan/results'
        LOCAL_FOLDER = 'C:\Users\Admin\Desktop\Development\Python\Github\docker-mount'
    }    


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
                bat 'docker ps -qf name=ml-cicd-v1 > container_id.txt'
                script {
                    def containerId = readFile('container_id.txt').trim()
                    println "Container ID: ${containerId}"
                    env.CONTAINER_ID = containerId
                }
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
        stage('Copy File') {
            steps {
                script {                    
                    bat "docker container exec ml-cicd-v1 cat ${FOLDER_NAME}/train_metadata.json ${FOLDER_NAME}/test_metadata.json" 
                    bat "docker cp ml-cicd-v1:${FOLDER_NAME}/train_metadata.json ${LOCAL_FOLDER}/train_metadata.json"
                    bat "docker cp ml-cicd-v1:${FOLDER_NAME}/test_metadata.json ${LOCAL_FOLDER}/test_metadata.json"
                }
            }
        }      
    }
}