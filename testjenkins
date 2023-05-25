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
    }
}