node {
   stage('SCM checkout'){
        checkout scm
    }
  stage 'Docker build'
  docker.build('sb_app')
 
  stage 'Docker push'
  docker.withRegistry('https://825764601905.dkr.ecr.us-west-2.amazonaws.com', 'ecr:us-west-2:ecr-credentials') {
    docker.image('sb_app').push('latest')
  }
}
