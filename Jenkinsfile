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
                sh 'mvn test'
            }

            }
        }

    }
}