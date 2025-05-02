pipeline {
    agent any

    environment {
        IMAGE_NAME = 'playwright-test-image'
        DOCKER_BUILDKIT = '1'  # Enable BuildKit for better builds
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/vandanajamnal02/playwrightProjectWithJenkins.git'
            }
        }

        stage('Build Image') {
            steps {
                sh '''
                    # Ensure clean environment
                    docker system prune -f
                    # Build with explicit ignore of Podman configs
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

    post {
        always {
            sh 'docker system prune -f || true'
        }
    }
}