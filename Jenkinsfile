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
                script{
                withSonarQubeEnv(credentialsId: 'sonar-auth-api1') {
                  sh 'mvn clean package sonar:sonar'
                }
              }
            }
         }
         stage('Qualitygate Status'){
            steps{
                script{
                    waitForQualityGate abortPipeline: false, credentialsId: 'sonar-auth-api1'

                }
            }
         }
         stage('Upload war to Nexus'){
            steps{
                script{
                    def readpomversion = readMavenPom file: 'pom.xml'
                    nexusArtifactUploader artifacts: 
                    [
                        [
                            artifactId: 'springboot',
                            classifier: '', file: 'target/Uber.jar',
                            type: 'jar'
                            ]
                            ], 
                            credentialsId: 'nexus-auth', 
                            groupId: 'com.example', 
                            nexusUrl: 'dummy2023.centralindia.cloudapp.azure.com:8081', 
                            nexusVersion: 'nexus3', 
                            protocol: 'http', 
                            repository: 'demoapp-release', 
                            version: "${readpomversion.ver}"
                }
            }
         }
    }
}