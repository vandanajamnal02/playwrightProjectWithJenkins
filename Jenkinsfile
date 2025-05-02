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

        stage('Prepare Podman Registry') {
      steps {
        sh 'sudo rm -f /etc/containers/registries.conf.d/000-default.conf || true'
      }
    }

      stage('Build Docker Image') {
      steps {
        sh 'podman build -t my-playwright-image .'
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
