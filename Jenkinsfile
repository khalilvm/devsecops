pipeline {
    agent any
    
    tools {
        maven 'Maven'
        jdk 'JDK21'
    }
    
    environment {
        SONAR_HOST_URL = 'http://192.168.121.240:9000'
        DOCKER_IMAGE = 'spring-devops-app'
        DOCKER_TAG = '1.0.0'
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
        
        stage('SonarQube Analysis') {
            steps {
                echo 'Running SonarQube code analysis...'
                withSonarQubeEnv('SonarQube') {
                    sh 'mvn sonar:sonar'
                }
            }
        }
        
        stage('Package') {
            steps {
                echo 'Creating JAR file...'
                sh 'mvn package -DskipTests'
            }
        }
        
        stage('Deploy to Nexus') {
            steps {
                echo 'Uploading artifacts to Nexus...'
                sh 'mvn deploy -DskipTests -s settings.xml'
            }
        }
        
        stage('Build Docker Image') {
            steps {
                echo 'Building Docker image...'
                sh "docker build -t ${DOCKER_IMAGE}:${DOCKER_TAG} ."
                sh "docker build -t ${DOCKER_IMAGE}:latest ."
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
            echo '📊 SonarQube: http://192.168.121.240:9000'
            echo '📦 Nexus: http://192.168.121.240:8081'
            echo "🐳 Docker Image: ${DOCKER_IMAGE}:${DOCKER_TAG}"
        }
        failure {
            echo '❌ Pipeline failed!'
        }
    }
}
