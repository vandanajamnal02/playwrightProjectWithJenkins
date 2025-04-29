pipeline {
    agent any
    environment {
        REPO_CREDS = credentials('github-private-repo')  // Reference credential ID
    }
    stages {
        stage('Checkout') {
            steps {
                checkout([
                    $class: 'GitSCM',
                    branches: [[name: 'main']],
                    extensions: [],
                    userRemoteConfigs: [[
                        url: 'https://github.com/vandanajamnal02/playwrightProjectWithJenkins.git',
                        credentialsId: 'github-private-repo'
                    ]]
                ])
            }
        }

        stage('Install Dependencies') {
            steps {
                sh 'npm install'
                sh 'npx playwright install'  // Install browsers
            }
        }

        stage('Run Tests') {
            steps {
                sh 'npm run test'  // Run all tests
                
                // Optional: Run specific tests or with additional flags
                // sh 'npx playwright test tests/example.spec.js --headed'
            }
        }

        stage('Generate Report') {
            steps {
                sh 'npx playwright show-report'  // Generate HTML report
            }
        }
    }
    
    post {
        always {
            // Archive test results (JUnit format)
            
            // Publish HTML report (requires HTML Publisher plugin)
            publishHTML(
                target: [
                    reportDir: 'playwright-report',
                    reportFiles: 'index.html',
                    reportName: 'Playwright HTML Report'
                ]
            )
            
            // Optional: Archive screenshots/videos
            archiveArtifacts artifacts: 'playwright-report/'
        }
    }
}