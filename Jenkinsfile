#!/usr/bin/groovy

pipeline {
    agent any

    options {
        disableConcurrentBuilds()
    }

    environment{
        AWS_ACCESS_KEY_ID= credentials('access-key-id')
        AWS_SECRET_ACCESS_KEY= credentials('secret-access-id')

    }
    
	

    stages {

        stage('Terraform Init'){
            steps {
                sh 'terraform init'
            }
        }

        stage('Terraform Validate'){
            steps {
                sh 'terraform validate'
            }
        }

        stage('Terraform Plan'){
            steps {
                sh 'terraform plan  -var-file=./vars/dev.tfvars '
            
            }
        }

        stage('Approve'){
            steps{
                approve()
            }
        }

        stage('Terraform Apply'){
            steps {
                sh 'terraform apply -var-file=./vars/dev.tfvars -auto-approve'
            }
        }

        stage('Destroy'){
            steps{
                destroy()
            }
        }
		
        stage('Terraform Destroy'){
            steps {
                sh 'terraform destroy -var-file=./vars/dev.tfvars -auto-approve'
            }
        }

	}
}


def approve() {

	timeout(time:1, unit:'DAYS') {
		input('Do you want to deploy to live?')
	}

}

def destroy() {

	timeout(time:1, unit:'DAYS') {
		input('Do you want to destroy terraform infra?')
	}

}