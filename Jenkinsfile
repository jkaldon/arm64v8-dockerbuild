pipeline {
  environment {
    ARTIFACT = "jkaldon/arm64v8-dockerbuild"
    BUILD_VERSION = sh(script: "echo `date -u +%Y%m%d`-${BUILD_NUMBER}", returnStdout: true).trim()
  }

  agent {
    kubernetes {
      inheritFrom 'jenkins-slave'
      defaultContainer 'docker'
      yaml """
apiVersion: v1
kind: Pod
spec:
  containers:
  - name: docker
    image: jkaldon/arm64v8-dockerbuild:alpine3.13
    command:
    - cat
    tty: true
    volumeMounts:
    - name: dockersock
      mountPath: "/var/run/docker.sock"
  volumes:
  - name: dockersock
    hostPath:
      path: /var/run/docker.sock
"""
    }
  }
  stages {
    stage('printenv') {
      steps {
        sh "printenv"
      }
    }
    stage('Build image') {
      steps {
        sh 'docker build --network host --no-cache --pull -t "${ARTIFACT}:${BUILD_VERSION}" .'
      }
    }
    stage('Publish image') {
      steps {
        withCredentials([[$class: 'UsernamePasswordMultiBinding',
                          credentialsId: 'jenkins-dockerhub',
                          usernameVariable: 'DOCKER_HUB_USER',
                          passwordVariable: 'DOCKER_HUB_PASSWORD']]) {
          sh '''
            docker login -u "${DOCKER_HUB_USER}" -p "${DOCKER_HUB_PASSWORD}"
            docker push "${ARTIFACT}:${BUILD_VERSION}"
          '''
        }
      }
    }
  }
}
