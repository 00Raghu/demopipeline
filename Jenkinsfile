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
                    sh 'docker image tag $JOB_NAME:v1.$BUILD_ID rcloud01/$JOB_NAME:v1.$BUILD_ID'
                    sh 'docker image tag $JOB_NAME:v1.$BUILD_ID rcloud01/$JOB_NAME:latest'
                }
            }
         }

         stage('PushImage to Dockerhub'){
            environment{
                DOCKERHUB_CEDENTIALS = credentials ('jenkins-dockerhub-auth')
            }

            steps{

                script{
                    sh 'echo $DOCKERHUB_CREDENTIALS_PSW | sudo docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'

                    // withCredentials([usernameColonPassword(credentialsId: 'jenkins-dockerhub-auth', variable: 'dockerhub-auth')]) {
                    // withCredentials([string(credentialsId: 'Dockerhubcred', variable: 'dockerhub-auth')]) {
                        // sh 'docker login -u rcloud01 --password-stdin ${dockerhub-auth}'
                        sh 'docker image push rcloud01/$JOB_NAME:v1.$BUILD_ID'
                        sh 'docker image push rcloud01/$JOB_NAME:v1.latest'
                        sh 'docker logout'

                        // withDockerRegistry(credentialsId: 'jenkins-dockerhub-auth', url: 'https://hub.docker.com/repositories/rcloud01') {
                        // docker.image("my-image:${env.BUILD_NUMBER}").push("${env.BUILD_NUMBER}")   
                    }
                }
            }     
        }
    }