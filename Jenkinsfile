pipeline {

    agent any
<<<<<<< HEAD
    
=======
    tools {
        maven 'maven3'
    }
>>>>>>> c4b5c1a4253c6badbc2fc262bb55b5963c75aa8f
    stages{
        stage('Git Checkout'){

            steps{
                git branch: 'main', url: 'https://github.com/00Raghu/demopipeline.git'
            }
        }
<<<<<<< HEAD
        stage('Unit Testing'){
            
=======
        stage('UNIT testing'){
          
>>>>>>> c4b5c1a4253c6badbc2fc262bb55b5963c75aa8f
            steps{
              script{
                     sh 'mvn test'
                }
            }
        }
    }
}
