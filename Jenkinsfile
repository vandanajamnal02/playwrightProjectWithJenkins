pipeline {
    agent any

    environment {
        IMAGE_NAME = 'playwright-test-image'
    }

    stages {
        stage('Verify Docker') {
            steps {
                script {
                    try {
                        def dockerVersion = sh(script: 'docker --version', returnStdout: true).trim()
                        echo "✅ Docker is installed: ${dockerVersion}"

                        def dockerInfoStatus = sh(script: 'docker info > /dev/null 2>&1', returnStatus: true)
                        if (dockerInfoStatus != 0) {
                            error("❌ Docker daemon is NOT running!")
                        } else {
                            echo "✅ Docker daemon is running"
                        }
                    } catch (Exception e) {
                        error("❌ Docker check failed: ${e.getMessage()}")
                    }
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                sh '''
                    docker build -t $IMAGE_NAME .
                '''
            }
        }

        stage('Run Playwright Tests') {
            steps {
                sh '''
                    docker run --rm \
                        -v $PWD:/app \
                        -w /app \
                        $IMAGE_NAME
                '''
            }
        }
    }
}
