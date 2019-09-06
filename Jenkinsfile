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
        script {

            if (env.BRANCH_NAME == "master") {
                bat 'grunt --path=D:\\TerraTex\\Spiele\\mta\\server\\mods\\deathmatch\\resources'
            }
        }
      }
    }
  }

  post {
      success {
          telegramSend "Eine neue Version wurde auf den MTA:SA Server geladen. Sie geht live mit dem nächsten GMX."

          script {
            if (env.BRANCH_NAME == "master") {
                  def telegram = "MTA:SA Änderungen: "
                  def publisher = LastChanges.getLastChangesPublisher "LAST_SUCCESSFUL_BUILD", "SIDE", "LINE", true, true, "", "", "", "", ""
                  publisher.publishLastChanges()
                  def changes = publisher.getLastChanges()
                  for (commit in changes.getCommits()) {
                      def commitInfo = commit.getCommitInfo()
                      telegram = """${telegram}
- ${commitInfo.getCommitMessage()}"""
                  }

                  telegramSend telegram
              } else {
                def telegram = "MTA:SA: Neuer PR auf Github mit: "
                                def publisher = LastChanges.getLastChangesPublisher "LAST_SUCCESSFUL_BUILD", "SIDE", "LINE", true, true, "", "", "", "", ""
                                publisher.publishLastChanges()
                                def changes = publisher.getLastChanges()
                                for (commit in changes.getCommits()) {
                                    def commitInfo = commit.getCommitInfo()
                                    telegram = """${telegram}
- ${commitInfo.getCommitMessage()}"""
                                }
                telegramSend telegram
              }
          }
      }
      failure {
          telegramSend "Es ist ein Fehler beim Deployen einer neuen Version auf den MTA:SA Server aufgetreten."
      }
  }
}
