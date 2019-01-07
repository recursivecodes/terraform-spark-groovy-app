pipeline {

    agent any

    environment {
        TF_VAR_tenancy_ocid = "ocid1.tenancy.oc1..aaaaaaaaoob7skc7pk2mtomsql3lumuav73fcdqe3lg7y43mhhfvwbha72bq"
        TF_VAR_user_ocid = "ocid1.user.oc1..aaaaaaaarst7uglhde4clzp3p4yu3flkm6nzqkwoazedntsnilh2bgljbqmq"
        TF_VAR_compartment_ocid = "ocid1.compartment.oc1..aaaaaaaa7lzppsdxt6j56zhpvy6u5gyrenwyc2e2h4fak5ydvv6kt7anizbq"
        TF_VAR_region = "us-phoenix-1"
        TF_VAR_private_key_path = credentials('OCI_API_KEY')
        TF_VAR_fingerprint = credentials('OCI_FINGERPRINT')
        TF_VAR_private_key_password = credentials('OCI_PRIVATE_KEY_PASSWORD')
        TF_VAR_ssh_private_key = credentials('ID_SPARK_TERRAFORM_PRIVATE')
        TF_VAR_ssh_public_key = credentials('ID_SPARK_TERRAFORM')
    }

    stages {

        stage('Checkout') {
            steps {
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
                    terraform plan -input=false -out=tfplan
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
                    terraform apply -input=false tfplan 
                """
            }
        }
    }
}