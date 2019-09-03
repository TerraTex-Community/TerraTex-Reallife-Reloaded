pipeline {
  agent {
    node {
      label 'windows'
    }

  }
  stages {
    stage('compile css') {
      steps {
        bat 'node-sass --output-sytle compressed terratex_reallife/UI/styles/css/uncompiled/ -r -o terratex_reallife/UI/styles/css'
      }
    }
    stage('prepare deployment') {
      steps {
        bat 'npm install'
      }
    }
    stage('deploy') {
      steps {
        bat 'grunt --path=D:\\TerraTex\\Spiele\\mta\\server\\mods\\deathmatch\\resources'
      }
    }
  }
}
