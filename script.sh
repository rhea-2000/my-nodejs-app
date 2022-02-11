ROLE_ARN="arn:aws:iam::993745358053:role/ecsTaskExecutionRole"
echo "ROLE_ARN= " $ROLE_ARN

FAMILY="node-task"
echo "FAMILY= " $FAMILY

NAME="node-js-r"
echo "NAME= " $NAME

sed -i "s#BUILD_NUMBER#$IMAGE_TAG#g" task-definition.json
sed -i "s#REPOSITORY_URI#$REPOSITORY_URI#g" task-definition.json
sed -i "s#ROLE_ARN#$ROLE_ARN#g" task-definition.json
sed -i "s#FAMILY#$FAMILY#g" task-definition.json
sed -i "s#NAME#$NAME#g" task-definition.json


aws ecs register-task-definition --cli-input-json file://task-definition.json --region="${AWS_DEFAULT_REGION}"

REVISION='aws ecs describe-task-definition --task-definition "${TASK_DEFINITION_NAME}" --region "${AWS_DEFAULT_REGION}" | jq .taskDefinition.revision'
echo "REVISION= " "${REVISION}"
aws ecs update-service --cluster "${CLUSTER_NAME}" --service "${SERVICE_NAME}" --task-definition "${TASK_DEFINITION_NAME}":"${REVISION}" --desired-count "${DESIRED_COUNT}"
