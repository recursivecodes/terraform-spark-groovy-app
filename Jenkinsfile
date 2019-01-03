pipeline {

    agent any

    environment {
        TF_VAR_compartment_ocid="ocid1.compartment.oc1..aaaaaaaa7lzppsdxt6j56zhpvy6u5gyrenwyc2e2h4fak5ydvv6kt7anizbq"
        TF_VAR_region="us-phoenix-1"
    }

    stages {

        stage('Checkout') {
            steps {
                echo ${credentials('oci_api_key')}
                echo "Yeah boi"
                checkout scm
            }
        }

        stage('init') {
            steps {
                sh  """
                    cd terraform/
                    terraform init -backend=true -input=false
                    """
            }
        }

        stage('plan') {
            steps {
                sh  """
                    cd terraform/
                    terraform plan -out=tfplan -input=false
                    """
                script {
                  timeout(time: 10, unit: 'MINUTES') {
                    input(id: "Deploy Gate", message: "Deploy App?", ok: 'Deploy')
                  }
                }
            }
        }

        stage('apply') {
            steps {
                sh  """
                    cd terraform/
                    terraform apply -lock=false -input=false tfplan
                    """
            }
        }
    }
}