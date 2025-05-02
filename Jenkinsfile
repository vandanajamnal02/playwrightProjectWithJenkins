pipeline {
    agent any

    environment {
        IMAGE_NAME = 'playwright-test-image'
        CONTAINER_NAME = 'playwright-test-container'
        // Force Docker usage
        DOCKER_BUILDKIT = '1'
        COMPOSE_DOCKER_CLI_BUILD = '1'
    }

    stages {
        stage('Verify Docker') {
            steps {
                sh '''
                    # Verify we're using Docker
                    docker --version
                    docker info | grep "Server Version"
                '''
            }
        }

        stage('Build Image') {
            steps {
                sh '''
                    # Completely ignore any Podman configurations
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