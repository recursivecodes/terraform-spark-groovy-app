pipeline {

    agent any

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('init') {
            steps {
                sh  """
                    terraform init -backend=true -input=false
                    """
            }
        }

        stage('plan') {
            steps {
                sh  """
                    terraform plan -out=tfplan -input=false
                    """
                script {
                  timeout(time: 10, unit: 'MINUTES') {
                    input(id: "Deploy Gate", message: "Deploy ${params.project_name}?", ok: 'Deploy')
                  }
                }
            }
        }

        stage('apply') {
            steps {
                sh  """
                    terraform apply -lock=false -input=false tfplan
                    """
            }
        }
    }
}