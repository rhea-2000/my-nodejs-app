pipeline {
    agent any
    environment {
            AWS_ACCOUNT_ID="993745358053"
            AWS_DEFAULT_REGION="us-east-1"
	    CLUSTER_NAME="node-js-app"
	    SERVICE_NAME="node-js-r"
	    TASK_DEFINITION_NAME="node-task"
	    DESIRED_COUNT="1"
            IMAGE_REPO_NAME="993745358053.dkr.ecr.us-east-1.amazonaws.com/my-docker-repo"
            IMAGE_TAG="latest"
            REPOSITORY_URI = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME}"
    }
    stages {
        stage ('Checkout') {
            steps {
              checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/rhea-2000/my-nodejs-app.git']]])
            }
        }
        stage ('Build') {
            steps {
                  script {
			              //dockerImage = docker.build "${IMAGE_REPO_NAME}:${IMAGE_TAG}"
			             //sh 'docker build -t ${IMAGE_REPO_NAME}:${IMAGE_TAG} .'
			               sh 'docker build -t my-docker-repo .'
                  }
             }    
         }
        stage ('Push') {
            steps {
                script {
                      sh "aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 993745358053.dkr.ecr.us-east-1.amazonaws.com"
		      //sh "aws ecr get-login-password --region us-east-1 | docker login --username jananirj --password-stdin 993745358053.dkr.ecr.us-east-1.amazonaws.com"
		      sh "docker tag my-docker-repo:latest 993745358053.dkr.ecr.us-east-1.amazonaws.com/my-docker-repo:latest"
                      sh "docker push 993745358053.dkr.ecr.us-east-1.amazonaws.com/my-docker-repo:latest"
                }
            }
        }
        stage('Deploy') {
             steps{
                 //withAWS(credentials:'Aws', region: "${AWS_DEFAULT_REGION}") 
		    withAWS(credentials:'Aws', region: 'us-east-1') {
                script {
			      sh 'sudo chmod 777 ./script.sh'
			      sh './script.sh'
			sh 'aws ecs register-task-definition --cli-input-json file://task-definition.json --region=us-east-1'
                }
            } 
        }
      }
   }
}    
