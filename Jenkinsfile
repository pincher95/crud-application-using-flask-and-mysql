def label = "worker-${UUID.randomUUID().toString()}"
def DockerImage = "crud_flask:v1.0"
def customImage = null

podTemplate(label: label, containers: [
  containerTemplate(name: 'docker', image: 'docker', command: 'cat', ttyEnabled: true),
  containerTemplate(name: 'kubectl', image: 'lachlanevenson/k8s-kubectl:v1.15.10', command: 'cat', ttyEnabled: true),
  containerTemplate(name: 'helm', image: 'lachlanevenson/k8s-helm:latest', command: 'cat', ttyEnabled: true),
  containerTemplate(name: 'mysql-client', image: 'arey/mysql-client:latest', command: 'cat', ttyEnabled: true)
],
volumes: [
  hostPathVolume(mountPath: '/var/run/docker.sock', hostPath: '/var/run/docker.sock')
]) {
  node(label) {
    stage('Git') { // Get code from GitLab repository
      git branch: 'master',
        url: 'https://github.com/pincher95/crud-application-using-flask-and-mysql.git'
    }
    stage('Init app DataBase') {
      container('mysql-client') {
        sh ("mysql -h mysql.service.consul -uroot -ptesting < database/crud_flask.sql")
      }
    }
    stage('Create Docker images') {
      container('docker') {
        customImage = docker.build "pincher95/crud_flask:${env.BUILD_NUMBER}"
      }
    }
    stage('Push Artifact to Docker Hub') {
      container('docker') {
        withDockerRegistry(registry: [credentialsId: 'dockerhub.pincher95',url: 'https://index.docker.io/v1/']) {
          sh ("docker push pincher95/crud_flask:${env.BUILD_NUMBER}")
        }
      }
    }
    stage('Deploy to K8s cluster') {
      container('kubectl') {
        withKubeConfig([credentialsId: env.K8s_CREDENTIALS_ID,
                        serverUrl: 'https://kubernetes.default']) {
            sh ("kubectl apply -f deployment.yaml")
        }
      }
    }
//     stage('Run helm') {
//       container('helm') {
//         sh "helm list"
//       }
//     }
  }
}