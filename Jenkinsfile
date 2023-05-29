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
                    def nexusrepo = readpomversion.version.endsWith("SNAPSHOT") ? "demoapp-snapshot" : "demoapp-release"
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
                            repository: nexusrepo, 
                            version: "${readpomversion.version}"
                }
            }
         }
         stage('Docker Image Build'){
            steps{
                script {
                    sh 'docker image build -t $JOB_NAME:v1.$BUILD_ID .'
                    sh 'docker image tag $JOB_NAME:v1.$BUILD_ID raghucurl/$JOB_NAME:v1.$BUILD_ID'
                    sh 'docker image tag $JOB_NAME:v1.$BUILD_ID raghucurl/$JOB_NAME:latest'
                }
            }
         }

         stage('PushImage to Dockerhub'){

            steps{

                script{
                    
                    withCredentials([usernameColonPassword(credentialsId: 'jenkins-dockerhub-auth', variable: 'jen-dochub-cred')]) {
                        sh 'docker login -u rcloud01 --password-stdin ${jen-dochub-cred}'
                        sh 'docker image push rcloud01/$JOB_NAME:v1.$BUILD_ID'
                        sh 'docker image push rcloud01/$JOB_NAME:v1.latest'    
                    }
                }
            }     
        }
    }
}