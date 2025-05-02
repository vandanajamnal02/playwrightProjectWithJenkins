pipeline {
    agent any

    environment {
        IMAGE_NAME = 'playwright-test-image'
    }

    stages {
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