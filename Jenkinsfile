pipeline {
    agent any
    parameters {
        choice(name: 'ENVIRONMENT',
            choices: [ 'DEVELOPMENT', 'PRODUCTION' ],
            description: 'Choose the environment for this deployment')
        choice(name: 'BRANCH',
            choices: [ 'dev', 'prod' ],
            description: 'Choose the Branch for the deployment')    
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
               git url:'https://github.com/pratham1951/mini-assignmentv2.git', branch :'$BRANCH'
                // checkout scm
            }
        }
        
        
        stage('BUILD') {
            steps {
                sh 'mvn clean install'
            }
        }
        
        stage('TEST') {
            steps {
                sh 'mvn test'
            }
        }

        stage('SONAR SCANNER') {
            environment {
            sonar_token = credentials('SONAR_TOKEN')
            }
            steps {
                sh 'mvn sonar:sonar -Dsonar.projectName=$JOB_NAME \
                    -Dsonar.projectKey=$JOB_NAME \
                    -Dsonar.host.url=https://orange-capybara-6wr67vp9vg7c4p6q-9000.app.github.dev/ \
                    -Dsonar.token=$sonar_token'
            }
        } 

         stage('Artifactory'){
            steps{
            
            rtUpload (
                serverId: 'artifactory-docker',
                spec: '''{
                      "files": [
                        {
                          "pattern": "*.war",
                          "target": "libs-local"
                        }
                     ]
                }''',
            )
            }
        }

        
        stage ('Deploy to Development environments') {
            when {
                expression { params.ENVIRONMENT != 'PRODUCTION' }
            }
            steps {
                echo "Deploying to ${params.ENVIRONMENT}"
                 script {
                   sh 'cp $WORKSPACE/target/*.war /home/ubuntu/apache-tomcat-9.0.82/webapps'
                }
             }
        }
        stage ('Deploy to production environment') {
            when {
                expression { params.ENVIRONMENT == 'PRODUCTION' }
            }
            steps {
                input message: 'Confirm deployment to production...', ok: 'Deploy'
                echo "Deploying to ${params.ENVIRONMENT}"
                script {
                   sh 'cp $WORKSPACE/target/*.war /home/ubuntu/apache-tomcat-9.0.82/app2'
                }
            }
        }
       
        stage('Email Notification')
        {
          steps{
              mail bcc: '', body: '''This Jenkins job ran successfully.
              Thanks & regards
              Pratham Sharma 
              ''', cc: '', from: '', replyTo: '', subject: 'Jenkins Job run Succesfully', to: 'sharmapratham1951@gmail.com'
          }
        }
    }    
     
}        