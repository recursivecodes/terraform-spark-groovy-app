pipeline {

    agent any

    environment {
        withCredentials([file(credentialsId: 'oci_api_key', variable: 'OCI_API_KEY')]) {
            TF_VAR_private_key_path=$OCI_API_KEY
        }
        TF_VAR_compartment_ocid="ocid1.compartment.oc1..aaaaaaaa7lzppsdxt6j56zhpvy6u5gyrenwyc2e2h4fak5ydvv6kt7anizbq"
        TF_VAR_region="us-phoenix-1"
    }

    stages {

        stage('Checkout') {
            steps {
                sh "echo $TF_VAR_private_key_path"
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