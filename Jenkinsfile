pipeline {

    agent any
    tools {
        maven 'Maven 3.9.2'
        jdk 'jdk8'
    }
   
    stages{
        stage('Git Checkout'){

            steps{
                git branch: 'main', url: 'https://github.com/00Raghu/demopipeline.git'
            }
        }
        stage('UNIT testing'){
            
               def mvnHome = tool name: 'maven3', type: 'maven'
               steps{
                   sh "${mvnHome}/bin/mvn test"
               }
        }
        
    }
}
