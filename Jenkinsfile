pipeline {
    agent any
    tools {
        maven 'maven3'
    }
    stages {
        stage('Example') {
            steps {
                sh 'mvn --version'
            }
        }
    }
}
