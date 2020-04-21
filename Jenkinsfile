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
    stage('Git') { // Get code from GitLab repository
      git branch: 'master',
        url: 'https://github.com/pincher95/crud-application-using-flask-and-mysql.git'
    }
    stage('Init app DataBase') {
      try {
        container('mysql-client') {
          sh """
            TABLE=echo \$(mysqlshow -h mysql -P3306 -u root -ptesting crud_flask |grep -iv 'wildcard\|database\|tables' |awk -F' ' '{print $2}')
            if [ TABLE != "phone_book" ]; then
              mysql -h mysql.service.consul -uroot -ptesting < database/crud_flask.sql
            else
              echo "Table already exist!!!..."
             fi
          """
        }
      }
      catch (exc) {
        println "Database already initialized"
        throw(exc)
      }
    }
    stage('Create Docker images') {
      container('docker') {
        customImage = docker.build "pincher95/crud_flask:${env.BUILD_NUMBER}"
      }
    }
    stage('Push Artifact to Docker Hub') {
      container('docker') {
        withRegistry(registry: [credentialsId: 'dockerhub.pincher95',url: 'https://index.docker.io/v1/']) {
          sh """
            docker push pincher95/crud_flask:${env.BUILD_NUMBER}
          """
        }
      }
    }
    stage('Run kubectl') {
      container('kubectl') {
        withCredentials([kubeconfigFile(credentialsId: 'kubeconfig', variable: 'KUBECONFIG')]) {
            sh '''cat $KUBECONFIG'''
        }
        sh "kubectl get pods -n kube-app"
      }
    }
//     stage('Run helm') {
//       container('helm') {
//         sh "helm list"
//       }
//     }
  }
}