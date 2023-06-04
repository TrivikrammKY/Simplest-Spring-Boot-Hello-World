pipeline {
    agent any

 stages {
     
        stage('git clone') {
            steps {
                git 'https://github.com/TrivikrammKY/Simplest-Spring-Boot-Hello-World.git'
            }
        }
  stage('maven build') {
          steps {
               sh 'mvn clean package'
          }
         
        }
        stage('maven test') {
          steps {
               sh 'mvn test'
          }
         
        }
        stage('SonarQube Analysis') {
    steps {
      sh '''mvn clean verify sonar:sonar \
  -Dsonar.projectKey=sonar \
  -Dsonar.projectName='sonar' \
  -Dsonar.host.url=http://3.95.151.243:9010 \
  -Dsonar.token=sqp_e2956d94b5be58186f7df8a6e2da77a0a8c9864d'''
    }
  }
           	 stage('saving the artifact') {
            steps {
                sh ''' 
                cp /var/lib/jenkins/workspace/test/target/project-${BUILD_NUMBER}.war /data/archives/project/project-$BUILD_NUMBER.jar
                '''
            }
        }
 stage('sast owasp') {
            steps {
              dependencyCheck additionalArguments: '''--project=test
--scan="/var/lib/jenkins/workspace/test"
--format="XML"''', odcInstallation: 'default'
            }
        }
         
         stage('Docker build') {
          steps {
              sh '''docker build -t testapp .'''
          }
         
        }
         stage('Docker run') {
          steps {
              sh '''docker rm -f $(docker ps -a -q) && docker run -d -it -p 8082:8080 --name testapp testapp'''
          }
         
        }
        	 stage('publish the report') {
            steps {
               dependencyCheckPublisher pattern: '**/dependency-check-report.xml'
            }
        }
      

 }
}
