pipeline {
    agent any
    
    tools {
        maven 'Maven'
        jdk 'JDK17'
    }
    
    stages {
        stage('Checkout') {
            steps {
                echo 'Pulling code from GitHub...'
                git branch: 'main', url: 'https://github.com/khalilvm/devsecops.git'
            }
        }
        
        stage('Build') {
            steps {
                echo 'Building with Maven...'
                sh 'mvn clean compile'
            }
        }
        
        stage('Test') {
            steps {
                echo 'Running tests...'
                sh 'mvn test'
            }
        }
        
        stage('Package') {
            steps {
                echo 'Creating JAR file...'
                sh 'mvn package -DskipTests'
            }
        }
        
        stage('Archive Artifacts') {
            steps {
                echo 'Archiving build artifacts...'
                archiveArtifacts artifacts: 'target/*.jar', fingerprint: true
            }
        }
    }
    
    post {
        success {
            echo '✅ Pipeline completed successfully!'
        }
        failure {
            echo '❌ Pipeline failed!'
        }
    }
}
