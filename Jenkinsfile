pipeline {
    agent any

    environment {
        IMAGE_NAME = 'playwright-test-image'
        CONTAINER_NAME = 'playwright-test-container'
    }

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/vandanajamnal02/playwrightProjectWithJenkins.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh 'docker build -t $IMAGE_NAME .'
                }
            }
        }

        stage('Run Tests in Docker Container') {
            steps {
                script {
                    sh """
                        docker run --rm \
                            -v \$PWD:/app \
                            -w /app \
                            $IMAGE_NAME \
                            npx playwright test
                    """
                }
            }
        }
    }

    post {
        always {
            echo 'Cleaning up Docker containers/images if needed'
            // Optional: Add cleanup logic
        }
    }
}
