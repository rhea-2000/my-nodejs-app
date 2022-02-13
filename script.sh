ROLE_ARN='"arn:aws:iam::993745358053:role/ecsTaskExecutionRole"'
echo "ROLE_ARN= " $ROLE_ARN

FAMILY='"node-task"'
echo "FAMILY= " $FAMILY

NAME='"node-js-r"'
echo "NAME= " $NAME

sed -i "s#BUILD_NUMBER#$IMAGE_TAG#g" task-definition.json
sed -i "s#REPOSITORY_URI#$REPOSITORY_URI#g" task-definition.json
sed -i "s#ROLE_ARN#$ROLE_ARN#g" task-definition.json
sed -i "s#FAMILY#$FAMILY#g" task-definition.json
sed -i "s#NAME#$NAME#g" task-definition.json


aws ecs register-task-definition --cli-input-json file://task-definition.json --region=us-east-1


