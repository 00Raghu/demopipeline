pipeline {

    agent any
    stages{
        stage('Git Checkout'){

            steps{
                git branch: 'main', url: 'https://github.com/00Raghu/demopipeline.git'
            }
        }
        stage('UNIT testing'){
            steps{            
               withMaven(maven: 'mvn') {
            sh 'mvn test'
        
                }
            }
        }
    }
}
