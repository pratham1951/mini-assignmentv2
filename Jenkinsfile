pipeline {
    agent any
    parameters {
        choice(name: 'ENVIRONMENT',
            choices: [ 'DEVELOPMENT', 'PRODUCTION' ],
            description: 'Choose the environment for this deployment')
        // choice(name: 'BRANCH',
        //     choices: [ 'dev', 'prod' ],
        //     description: 'Choose the Branch for the deployment')    
    }
    tools {
       maven "MAVEN_HOME"
       jdk "JAVA_HOME"
    }
    
    stages {

        stage('CLEAN WORKSPACE') {
            steps {
                cleanWs()
            }
        }
        
        stage('CODE CHECKOUT') {
            steps {
               git url:'https://github.com/pratham1951/mini-assignmentv2.git', branch:'$BRANCH'
                // checkout scm
            }
        }
        
        
        stage('BUILD') {
            steps {
                sh 'mvn clean install'
            }
        }
        
        // stage('TEST') {
        //     steps {
        //         sh 'mvn test'
        //     }
        // }

        stage('ENVIRONMENTS')
        {
            steps{
                echo 'echo $BRANCH'
                echo 'echo $env.BRANCH'
            }
        }
        // stage('When Stage') {
        //     when {
        //         expression { env.BRANCH_NAME == 'prod'}
        //         }
        //     steps {
        //         echo "Run this stage - ony if the branch is Prod"
        //     }

        
        stage ('Deploy to Development environments') {
            when {
                expression { params.ENVIRONMENT != 'PRODUCTION' }
            }
            steps {
                echo "Deploying to ${params.ENVIRONMENT}"
               
                
            }
        }
        stage ('Deploy to production environment') {
            when {
                expression { params.ENVIRONMENT == 'PRODUCTION' }
            }
            steps {
                input message: 'Confirm deployment to production...', ok: 'Deploy'
                echo "Deploying to ${params.ENVIRONMENT}"
            }
        }
       
        // stage('Email Notification')
        // {
        //   steps{
        //       mail bcc: '', body: '''This Jenkins job ran successfully.
        //       Thanks & regards
        //       Pratham Sharma 
        //       ''', cc: '', from: '', replyTo: '', subject: 'Jenkins Job run Succesfully', to: 'sharmapratham1951@gmail.com'
        //   }
        // }
    }    
     
}        