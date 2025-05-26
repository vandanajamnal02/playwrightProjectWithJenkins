pipeline {
    agent any

    environment {
        IMAGE_NAME = 'playwright-test-image'
    }

    stages {
        stage('Verify Docker') {
            steps {
                script {
                    def dockerAvailable = false
                    try {
                        def version = sh(script: 'docker --version', returnStdout: true).trim()
                        echo "✅ Docker installed: ${version}"

                        def infoStatus = sh(script: 'docker info > /dev/null 2>&1', returnStatus: true)
                        if (infoStatus == 0) {
                            echo "✅ Docker daemon is running"
                            dockerAvailable = true
                        } else {
                            echo "❌ Docker daemon is NOT running"
                        }
                    } catch (Exception e) {
                        echo "❌ Docker check failed: ${e.getMessage()}"
                    }
                    // Save in env variable for next stages
                    env.DOCKER_AVAILABLE = dockerAvailable.toString()
                }
            }
        }

        stage('Build Docker Image') {
            when {
                expression { env.DOCKER_AVAILABLE == 'true' }
            }
            steps {
                sh "docker build -t $IMAGE_NAME ."
            }
        }

        stage('Run Playwright Tests') {
            when {
                expression { env.DOCKER_AVAILABLE == 'true' }
            }
            steps {
                sh """
                    docker run --rm \
                        -v \$PWD:/app \
                        -w /app \
                        $IMAGE_NAME
                """
            }
        }
    }
}
