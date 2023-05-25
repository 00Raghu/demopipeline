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
               def mvnHome = tool name: 'maven3', type: 'maven'
            }
               steps{
                   sh "${mvnHome}/bin/mvn test"
               }
        }
        
    }
}
