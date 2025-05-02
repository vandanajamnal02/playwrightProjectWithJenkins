pipeline {
    agent any

    environment {
        IMAGE_NAME = 'playwright-test-image'
        CONTAINER_NAME = 'playwright-test-container'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/vandanajamnal02/playwrightProjectWithJenkins.git'
            }
        }

        stage('Build Image') {
            steps {
               sh 'podman build --registries-conf=/dev/null -t $IMAGE_NAME .'
            }
        }

        stage('Run Tests in Container') {
            steps {
                script {
                    sh """
                        podman run --rm \
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
            sh 'docker system prune -f || true'
        }
    }
}
