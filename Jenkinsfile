pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                node {
                    checkout scm
                }
                echo 'Building..'
            }
        }
        stage('Test') {
            steps {
                echo 'Testing..'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
    }
}