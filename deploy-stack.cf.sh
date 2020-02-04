#!/bin/bash

STACK_NAME=goodpartsofaws
REGION=eu-central-1
CLI_PROFILE=default

EC2_INSTANCE_TYPE=t2.micro #free

echo -e "\n\n==Deploying stack.cf.yaml===\n"
aws cloudformation deploy \
  --region $REGION \
  --profile $CLI_PROFILE \
  --stack-name $STACK_NAME \
  --template-file stack.cf.yaml \
  --no-fail-on-empty-changeset \
  --capabilities CAPABILITY_NAMED_IAM \
  --parameter-overrides \
    EC2InstanceType=$EC2_INSTANCE_TYPE


if [$? -eq 0]; then
  aws cloudformation list-exports \
    --profile $CLI_PROFILE \
    --query "Exports[?Name=='InstanceEndpoint'].Value"
fi