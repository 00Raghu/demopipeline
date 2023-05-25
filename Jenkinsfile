pipeline {

    agent any
   
    stages{
        stage('Git Checkout'){

            steps{
                git branch: 'main', url: 'https://github.com/00Raghu/demopipeline.git'
            }
        }
        stage('UNIT testing'){
            
               def mvnHome = tool name: 'maven3', type: 'maven'
                sh "${mvnHome}/bin/mvn test"
        }
        
    }
}
