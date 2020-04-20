def label = "worker-${UUID.randomUUID().toString()}"
def DockerImage = "crud_flask:v1.0"
def customImage = null

podTemplate(label: label, containers: [
  containerTemplate(name: 'docker', image: 'docker', command: 'cat', ttyEnabled: true),
  containerTemplate(name: 'kubectl', image: 'lachlanevenson/k8s-kubectl:v1.8.8', command: 'cat', ttyEnabled: true),
  containerTemplate(name: 'helm', image: 'lachlanevenson/k8s-helm:latest', command: 'cat', ttyEnabled: true),
  containerTemplate(name: 'mysql-client', image: 'arey/mysql-client:latest', command: 'cat', ttyEnabled: true)
],
volumes: [
  hostPathVolume(mountPath: '/var/run/docker.sock', hostPath: '/var/run/docker.sock')
]) {
  node(label) {
//     def myRepo = checkout scm
//     def gitCommit = myRepo.GIT_COMMIT
//     def gitBranch = myRepo.GIT_BRANCH
//     def shortGitCommit = "${gitCommit[0..10]}"
//     def previousGitCommit = sh(script: "git rev-parse ${gitCommit}~", returnStdout: true)
    stage('Git') { // Get code from GitLab repository
      git branch: 'master',
        url: 'https://github.com/pincher95/crud-application-using-flask-and-mysql.git'
    }

    stage('Init app DataBase') {
      container('mysql-client') {
        sh """
          mysql -h mysql.service.consul -uroot -ptesting < database/crud_flask.sql
        """
      }
    }
//     stage('Test') {
//       try {
//         container('gradle') {
//           sh """
//             pwd
//             echo "GIT_BRANCH=${gitBranch}" >> /etc/environment
//             echo "GIT_COMMIT=${gitCommit}" >> /etc/environment
//             gradle test
//             """
//         }
//       }
//       catch (exc) {
//         println "Failed to test - ${currentBuild.fullDisplayName}"
//         throw(exc)
//       }
//     }
//     stage('Build') {
//       container('gradle') {
//         sh "gradle build"
//       }
//     }
    stage('Create Docker images') {
      container('docker') {
        customImage = docker.build "pincher95/crud_flask:${env.BUILD_NUMBER}"
//         withCredentials([[$class: 'UsernamePasswordMultiBinding',
//           credentialsId: 'dockerhub.pincher95',
//           usernameVariable: 'DOCKER_HUB_USER',
//           passwordVariable: 'DOCKER_HUB_PASSWORD']]) {
//           sh """
//             docker login -u ${DOCKER_HUB_USER} -p ${DOCKER_HUB_PASSWORD}
//             docker build -t namespace/my-image:${gitCommit} .
//             docker push namespace/my-image:${gitCommit}
//             """
//         }
      }
    }
    stage('Push Artifact to Docker Hub') {
      container('') {

      }

    }
//     stage('Run kubectl') {
//       container('kubectl') {
//         sh "kubectl get pods"
//       }
//     }
//     stage('Run helm') {
//       container('helm') {
//         sh "helm list"
//       }
//     }
  }
}