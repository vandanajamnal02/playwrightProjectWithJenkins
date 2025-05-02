pipeline {
    agent any

    tools {
        nodejs 'Node 20' // Make sure "Node 20" is configured under Manage Jenkins > Global Tool Configuration
    }

    environment {
        HOME = "${WORKSPACE}"
    }

    stages {
        stage('Checkout Code') {
            steps {
                git url: 'https://github.com/vandanajamnal02/playwrightProjectWithJenkins.git', branch: 'main'
            }
        }

        stage('Install Dependencies') {
            steps {
                sh 'npm install'
                sh 'npx playwright install --with-deps'
            }
        }

        stage('Make Script Executable') {
            steps {
                sh 'chmod +x run-playwright-tests.sh'
            }
        }

        stage('Run Playwright Tests') {
            steps {
                sh './run-playwright-tests.sh'
            }
        }
    }

    post {
        always {
            archiveArtifacts artifacts: 'playwright-report/**', allowEmptyArchive: true
        }
        success {
            echo '✅ Tests completed successfully!'
        }
        failure {
            echo '❌ Tests failed. Check the logs.'
        }
    }
}
