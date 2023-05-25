pipeline {

    agent any
   
    stages{
        stage('Git Checkout'){

            steps{
                git branch: 'main', url: 'https://github.com/00Raghu/demopipeline.git'
            }
        }
        stage('Unit Testing'){
            steps{
                 def mvnHome = tool name: 'Apache Maven 3.9.2', type: 'maven'
                 sh "${mvnHome}/opt/mvn test'
            }
        }
    }
}

