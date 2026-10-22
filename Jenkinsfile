pipeline {
    agent any
 
    parameters {
        choice(name: 'ACTION', choices: ['apply', 'destroy'],
               description: 'apply = create/update, destroy = remove everything')
    }
 
    stages {
        stage('Terraform Version') {
            steps { sh 'terraform -version' }
        }
        stage('Terraform Init') {
            steps { sh 'terraform init -input=false -no-color' }
        }
        stage('Terraform Validate') {
            steps { sh 'terraform validate -no-color' }
        }
        stage('Terraform Plan') {
            when { expression { params.ACTION == 'apply' } }
            steps { sh 'terraform plan -input=false -no-color -out=tfplan' }
        }
        stage('Approval') {
            steps {
                input message: "Run terraform ${params.ACTION}?",
                      ok: 'Yes, go ahead'
            }
        }
        stage('Terraform Apply') {
            when { expression { params.ACTION == 'apply' } }
            steps { sh 'terraform apply -input=false -no-color tfplan' }
        }
        stage('Terraform Destroy') {
            when { expression { params.ACTION == 'destroy' } }
            steps { sh 'terraform destroy -auto-approve -no-color' }
        }
    }
 
    post {
        success { sh 'terraform output -no-color || true' }
    }
}
