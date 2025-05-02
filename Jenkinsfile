// pipeline {
//      agent {
//     docker {
//       image 'mcr.microsoft.com/playwright:v1.43.1-jammy'  // Ubuntu 22.04 with Playwright
//       args '-u root'  // optional if you need root access
//     }
//   }
//     stages {
//         stage('Checkout') {
//             steps {
//                 git 'https://github.com/vandanajamnal02/playwrightProjectWithJenkins.git'
//             }
//         }

        
//         stage('Install dependencies') {
//             steps {
//                 sh 'npm ci'
//                 sh 'npx playwright install'
//             }
        
//         }

//     //     stage('Install Browser Dependencies') {
//     //     steps {
//     //     sh '''
//     //         sudo apt-get update
//     //         sudo apt-get install -y \
//     //             libnss3 libatk-bridge2.0-0 libxss1 libasound2 libgtk-3-0 \
//     //             libx11-xcb1 libxcb-dri3-0 libdrm2 libgbm1 libxcomposite1 \
//     //             libxdamage1 libxrandr2 libu2f-udev libglu1-mesa \
//     //             libpango-1.0-0 libpangocairo-1.0-0
//     //     '''
//     // }
//     // }
//         stage('Run Tests') {
//             steps {
                
            

//             try {

//                     def testExitCode = sh(
//                         script: 'npm run test',
//                         returnStatus: true  // Continue even if tests fail
//                     )
//                     currentBuild.result = testExitCode == 0 ? 'SUCCESS' : 'FAILURE'
//                     error("Stopping pipeline after tests")  // Immediate exit
                        
//                     } finally {
//                         // Cleanup browsers
//                         sh 'pkill -f "playwright" || true'
//                     }
//                     }
//         }
//     }
//     post {
//         always {
//            sh 'find . -name "index.html" || true'
                
//                 // Archive with correct path
//                 archiveArtifacts artifacts: 'playwright-report/**/*', 
//                                 allowEmptyArchive: false
                
//                 // Optional: Publish HTML report
//                 publishHTML target: [
//                     reportDir: 'playwright-report',
//                     reportFiles: 'index.html',
//                     reportName: 'Playwright Report'
//                 ]
//         }
//     }
// }

pipeline {
    agent any

    tools {
        nodejs 'Node 20' // Must match the name set in Jenkins' Global Tool Configuration
    }

    environment {
        HOME = "${WORKSPACE}"
    }

    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/vandanajamnal02/playwrightProjectWithJenkins.git', branch: 'main'
            }
        }

        stage('Run Tests with Script') {
            steps {
                sh './run-playwright-tests.sh'
            }
        }
    }

    post {
        always {
            archiveArtifacts artifacts: 'playwright-report/**', allowEmptyArchive: true
        }
    }
}

