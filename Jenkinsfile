pipeline {
  agent {
    node {
      label 'windows'
    }

  }
  stages {
    stage('compile css') {
      steps {
        sh 'node-sass --output-sytle compressed terratex_reallife/UI/styles/css/uncompiled/ -r -o terratex_reallife/UI/styles/css'
      }
    }
  }
}