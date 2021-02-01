pipeline {

    agent any 
    stages {
        stage('Build') {
            steps {
                echo 'This step is building the app..!!'
            }
        }

        stage('Test') { 
            steps {
                echo 'Now i am running the test for app.'
                cat file1
                
            }
        }

        stage('Deploy') { 
            steps {
                echo 'Finally deploying the code.'
    }
  }
 }
}