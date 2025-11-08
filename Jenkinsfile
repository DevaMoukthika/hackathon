pipeline {
    agent { label 'windows' }  // Assuming a Windows agent with Python installed
    
    parameters {
        choice(name: 'BROWSER', choices: ['chrome', 'firefox', 'edge'], description: 'Browser to run tests against')
        string(name: 'TEST_PATH', defaultValue: 'tests/search_test.robot', description: 'Path to test file or directory')
    }
    
    environment {
        PYTHONUNBUFFERED = '1'
    }
    
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        
        stage('Setup Python Environment') {
            steps {
                powershell '''
                    cd Web
                    # Create and activate virtual environment
                    python -m venv .venv
                    .\.venv\Scripts\Activate.ps1
                    
                    # Upgrade pip and install requirements
                    python -m pip install --upgrade pip
                    pip install -r requirements.txt
                '''
            }
        }
        
        stage('Run Robot Tests') {
            steps {
                powershell '''
                    cd Web
                    .\.venv\Scripts\Activate.ps1
                    
                    # Run robot tests with specified browser
                    robot --variable BROWSER:${env:BROWSER} `
                         --outputdir reports `
                         --xunit junit_output.xml `
                         ${env:TEST_PATH}
                '''
            }
        }
    }
    
    post {
        always {
            dir('Web') {
                // Archive the robot results
                archiveArtifacts artifacts: 'reports/**/*.*', allowEmptyArchive: true
                
                // Publish test results
                junit 'junit_output.xml'
                
                // Publish Robot Framework report using HTML Publisher plugin
                publishHTML(target: [
                    allowMissing: false,
                    alwaysLinkToLastBuild: true,
                    keepAll: true,
                    reportDir: 'reports',
                    reportFiles: 'report.html,log.html',
                    reportName: 'Robot Framework Report'
                ])
            }
        }
    }
}