pipeline {
    agent any
    tools {
        maven 'maven3'
    }
    stages {
        stage('Git Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/00Raghu/demopipeline.git'
            }
        }
        stage('UNIT testing') {
            steps {
                script {
                    sh 'mvn test'
                }
            }
        }
        stage('Integration testing') {
            steps {
                script {
                    sh 'mvn verify -DskipTests'
                }
            }
        }
        stage('Maven Build') {
            steps {
                sh 'mvn clean install'
            }
        }
        stage('Static Code Analysis') {
            steps {
                script {
                    withSonarQubeEnv(credentialsId: 'sonar-auth-api1') {
                        sh 'mvn clean package sonar:sonar'
                    }
                }
            }
        }
        stage('Quality Gate Status') {
            steps {
                script {
                    waitForQualityGate abortPipeline: false, credentialsId: 'sonar-auth-api1'
                }
            }
        }
        stage('Upload WAR to Nexus') {
            steps {
                script {
                    def readPomVersion = readMavenPom file: 'pom.xml'
                    def nexusRepo = readPomVersion.version.endsWith("SNAPSHOT") ? "demoapp-snapshot" : "demoapp-release"
                    nexusArtifactUploader artifacts: [
                        [
                            artifactId: 'springboot',
                            classifier: '',
                            file: 'target/Uber.jar',
                            type: 'jar'
                        ]
                    ],
                    credentialsId: 'nexus-auth',
                    groupId: 'com.example',
                    nexusUrl: 'dummy2023.centralindia.cloudapp.azure.com:8081',
                    nexusVersion: 'nexus3',
                    protocol: 'http',
                    repository: nexusRepo,
                    version: "${readPomVersion.version}"
                }
            }
        }
        stage('Docker Image Build') {
            steps {
                script {
                    sh "docker image build -t $JOB_NAME:v1.$BUILD_ID ."
                    sh "docker image tag $JOB_NAME:v1.$BUILD_ID rcloud01/$JOB_NAME:v1.$BUILD_ID"
                    sh "docker image tag $JOB_NAME:v1.$BUILD_ID rcloud01/$JOB_NAME:latest"
                }
            }
        }
        stage('Push Image to Docker Hub') {
            environment {
                DOCKER_HUB_USERNAME = credentials('jenkins-dockerhub-auth')
                DOCKER_HUB_PASSWORD = credentials('jenkins-dockerhub-auth')
                DOCKER_HUB_REPO = 'https://hub.docker.com/repository/docker/rcloud01/demopipeline'
            }
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'jenkins-dockerhub-auth', usernameVariable: 'DOCKER_HUB_USERNAME', passwordVariable: 'DOCKER_HUB_PASSWORD')]) {
                        sh "docker login -u $DOCKER_HUB_USERNAME -p $DOCKER_HUB_PASSWORD"
                        sh "docker image push rcloud01/$JOB_NAME:v1.$BUILD_ID"
                        sh "docker image push rcloud01/$JOB_NAME:latest"
                        sh "docker logout"
                    }
                }
            }
        }
    }
    post {
        success {
            echo 'Docker image pushed to Docker Hub successfully!'
        }
        failure {
            echo 'Failed to push Docker image to Docker Hub.'
        }
    }
}
