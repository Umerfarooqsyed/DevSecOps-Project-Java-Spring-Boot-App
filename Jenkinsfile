pipeline {

    agent { label 'Slave 1' }

    environment {
        GITHUB_TOKEN= credentials('github-token')
        GIT_USER_NAME= "Umerfarooqsyed"
        GIT_USER_EMAIL= "umerfarooqsyed18@gmail.com"
        GIT_REPO_NAME= "DevSecOps-Project-Java-Spring-Boot-App"
        LATEST_IMAGE= "umerfarooqsyed/java-spring-boot-app:v${BUILD_NUMBER}"
        DOCKER_USER= "umerfarooqsyed"
        DOCKER_PASS= credentials('docker-token')
        SONAR_TOKEN= credentials('sonar-token')
        SONAR_URL= "http://34.201.116.83:9000"
    }

    stages {
        stage('Docker Agent') {
            steps {
                script {
                    docker.image('abhishekf5/maven-abhishek-docker-agent:v1')
                          .inside('--user root -v /var/run/docker.sock:/var/run/docker.sock') {

                        stage('Clean Workspace') {
                            cleanWs()
                        }

                        stage('Package into jar file using Maven') {
                            sh 'mvn clean package'
                        }

                        stage('SonarQube Static Code Analysis') {
                            sh 'mvn sonar:sonar -Dsonar.login=$SONAR_TOKEN -Dsonar.host.url=${SONAR_URL}'
                        }

                        stage('Build Docker Image and Push to Dockerhub') {
                            script {
                                sh '''
                                docker login -u $DOCKER_USER -p $DOCKER_PASS
                                docker build -t ${LATEST_IMAGE} .
                                docker push ${LATEST_IMAGE}
                                echo "Latest docker image pushed to your docker hub account"
                                '''
                            }
                        }

                        stage('Update k8s manifest file') {
                            sh '''
                            chmod +x /scripts/update-k8s-manifest.sh
                            ./update-k8s-manifest.sh
                            '''
                        }
                    } 
                }
            }
        }
    }
}
