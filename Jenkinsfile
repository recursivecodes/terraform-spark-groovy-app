pipeline {

    agent any

    environment {
        TF_VAR_tenancy_ocid="ocid1.tenancy.oc1..aaaaaaaaoob7skc7pk2mtomsql3lumuav73fcdqe3lg7y43mhhfvwbha72bq"
        TF_VAR_user_ocid="ocid1.user.oc1..aaaaaaaarst7uglhde4clzp3p4yu3flkm6nzqkwoazedntsnilh2bgljbqmq"
        TF_VAR_fingerprint="$OCI_API_KEY"
        TF_VAR_compartment_ocid="ocid1.compartment.oc1..aaaaaaaa7lzppsdxt6j56zhpvy6u5gyrenwyc2e2h4fak5ydvv6kt7anizbq"
        TF_VAR_region="us-phoenix-1"
    }

    stages {

        stage('Checkout') {
            steps {
                withCredentials([file(credentialsId: 'OCI_API_KEY', variable: 'OCI_API_KEY')]) {
                    sh "cp $OCI_API_KEY /tmp/booya.pem"
                    sh "echo 'booyakasha'"
                }
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