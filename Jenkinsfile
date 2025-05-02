pipeline {
    agent any

    environment {
        IMAGE_NAME = 'playwright-test-image'
        // Force Docker isolation
        DOCKER_BUILDKIT = '1'
    }

    stages {
        stage('Verify Docker') {
            steps {
                sh '''
                    docker --version || { echo "ERROR: Docker not installed!"; exit 1; }
                    if command -v podman &> /dev/null; then
                        echo "WARNING: Podman is installed and may interfere!"
                        exit 1
                    fi
                '''
            }
        }

        stage('Build Image') {
            steps {
                sh '''
                    DOCKER_CONFIG=/dev/null docker build \
                        --no-cache \
                        -t $IMAGE_NAME .
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