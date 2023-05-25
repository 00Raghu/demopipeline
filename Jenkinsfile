pipeline {

    agent any
    tools {
    maven 'M3'
    }
    stages{
        stage('Git Checkout'){

            steps{
                git branch: 'main', url: 'https://github.com/00Raghu/demopipeline.git'
            }
        }
        stage('Unit Testing'){
            steps{
                 def mvnHome = tool name: 'maven3', type: 'maven'
                 sh "${mvnHome}/opt/mvn test'
            }
        }
    }
}

