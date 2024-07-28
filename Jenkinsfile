node {
    def commitHash

    stage('SCM checkout') {
        checkout scm
        commitHash = sh(script: "git rev-parse --short HEAD", returnStdout: true).trim()
    }

    stage('Docker build') {
        docker.build("sb_app:${commitHash}")
    }

    stage('Docker push') {
        docker.withRegistry('https://825764601905.dkr.ecr.us-west-2.amazonaws.com/sb_app', 'ecr:us-west-2:ecr-credentials') {
            docker.image("sb_app:${commitHash}").push()
        }
    }
}