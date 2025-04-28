pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/vandanajamnal02/playwrightProjectWithJenkins.git'
            }
        }
        stage('Install dependencies') {
            steps {
                sh 'npm ci'
                sh 'npx playwright install'
            }
        }
        stage('Run Tests') {
            steps {
                
            

            try {
                        sh 'npm run test'
                    } finally {
                        // Cleanup browsers
                        sh 'pkill -f "playwright" || true'
                    }
                    }
        }
        stage('Archive Test Report') {
            steps {
                archiveArtifacts artifacts: 'playwright-report/**', allowEmptyArchive: true
            }
        }
    }
    post {
        always {
            publishHTML(target: [
                reportDir: 'playwright-report',
                reportFiles: 'index.html',
                reportName: 'Playwright Test Report'
            ])
        }
    }
}
