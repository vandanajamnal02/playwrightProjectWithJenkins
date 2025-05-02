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
                        // Check Docker version (will fail if Docker not running)
                        def dockerVersion = sh(script: 'docker --version', returnStdout: true).trim()
                        echo "✅ Docker is installed: ${dockerVersion}"
                        
                        // Check if Docker daemon is running
                        def dockerStatus = sh(script: 'docker info', returnStdout: true, returnStatus: true)
                        if (dockerStatus != 0) {
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
        stage('Build Image') {
            steps {
                sh '''
                    # Clean up any previous builds
                    docker system prune -f || true
                    
                    # Build with proper no-cache syntax
                    docker build --no-cache -t $IMAGE_NAME .
                '''
            }
        }

        stage('Run Tests') {
            steps {
                sh '''
                    docker run --rm \
                        -v $PWD:/app \
                        -w /app \
                        $IMAGE_NAME \
                        npx playwright test
                '''
            }
        }
    }
}