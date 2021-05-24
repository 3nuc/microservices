#!/bin/bash

CLI_PROFILE=default
STACK_NAME=rownolegle
REGION=eu-central-1
EC2_INSTANCE_TYPE=t3.nano #cheapest i think
OPERATOR_EMAIL=atagisow@protonmail.com
KEY_NAME=rownolegle

echo -e "\n==Deploying stack.cf.yaml===\n"
aws cloudformation deploy \
  --region $REGION \
  --profile $CLI_PROFILE \
  --stack-name $STACK_NAME \
  --template-file stack.cf.json \
  --no-fail-on-empty-changeset \
  --capabilities CAPABILITY_NAMED_IAM \
  --parameter-overrides \
    InstanceType=$EC2_INSTANCE_TYPE \
    OperatorEMail=$OPERATOR_EMAIL \
    KeyName=$KEY_NAME \

if [$? -eq 0]; then
  aws cloudformation list-exports \
    --profile $CLI_PROFILE \
    --query "Exports[?Name=='InstanceEndpoint'].Value"
fi
