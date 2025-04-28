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

                    def testExitCode = sh(
                        script: 'npm run test',
                        returnStatus: true  // Continue even if tests fail
                    )
                    currentBuild.result = testExitCode == 0 ? 'SUCCESS' : 'FAILURE'
                    error("Stopping pipeline after tests")  // Immediate exit
                        
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
            archiveArtifacts artifacts: 'playwright-report/**', 
                            allowEmptyArchive: true
        }
    }
}
