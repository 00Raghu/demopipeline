pipeline {

    agent any
    tools {
        maven 'maven3'
    }
    stages{
        stage('Git Checkout'){

            steps{
                git branch: 'main', url: 'https://github.com/00Raghu/demopipeline.git'
            }
        }
        stage('UNIT testing'){
          
            steps{
              script{
                     sh 'mvn test'
                }
            }
        }
         stage('Integration testing'){
          
            steps{
              script{
                     sh 'mvn verify -DskipUnitTests'
                }
            }
         }
         stage('Maven Build'){

            steps{
                sh 'mvn clean install'
            }
         }
         stage('StaticCode Analysis'){
            steps{
                withSonarQubeEnv(credentialsId: 'sonar-auth-api1') {
                  sh 'mvn clean package sonar:sonar'             
              }
            }
         }
    }
}