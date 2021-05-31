pipeline {
  environment {
    def ARTIFACT = "jkaldon/arm64v8-dockerbuild"
    def BUILD_VERSION = sh(script: "echo `date -u +%Y%m%d`", returnStdout: true).trim()
  }

  agent {
    kubernetes {
      label 'arm64v8-alpine'    // all your pods will be named with this prefix, followed by a unique id
      defaultContainer 'alpine' // define a default container if more than a few stages use it, will default to jnlp container
      yaml """
apiVersion: v1
kind: Pod
spec:
  containers:
  - name: alpine
    image: arm64v8/alpine:3.13
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
    stage('Install docker') {
      steps {
        sh "apk add docker"
      }
    }
    stage('Build image') {
      steps {
        sh "docker build --network host --no-cache --pull -t ${ARTIFACT}:${BUILD_VERSION} ."
      }
    }
    stage('Publish image') {
      steps {
        withCredentials([[$class: 'UsernamePasswordMultiBinding',
                          credentialsId: 'jenkins-dockerhub',
                          usernameVariable: 'DOCKER_HUB_USER',
                          passwordVariable: 'DOCKER_HUB_PASSWORD']]) {
          sh """
            docker login -u ${DOCKER_HUB_USER} -p ${DOCKER_HUB_PASSWORD}
            docker push -t ${ARTIFACT}:${BUILD_VERSION}
          """
        }
      }
    }
  }
}
