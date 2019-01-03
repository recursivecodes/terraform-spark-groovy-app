pipeline {
  agent any
  stages {
    stage('Build') {
      steps {
        echo 'Building..'
      }
    }
    stage('Test') {
      steps {
        echo 'Testing..'
      }
    }

    stage('Deploy') {
        def tfHome = tool name: 'Terraform', type: 'com.cloudbees.jenkins.plugins.customtools.CustomTool'
        env.PATH = "${tfHome}:${env.PATH}"
        cd terraform/

        steps {
            echo 'Deploying....'
            sh 'terraform init'
        }
    }
  }
}