#!/bin/bash

CLI_PROFILE=default
STACK_NAME=rownolegle

REGION=eu-central-1
EC2_INSTANCE_TYPE=t3.nano #cheapest i think

#go to https://eu-central-1.console.aws.amazon.com/vpc/home?region=eu-central-1#vpcs:
VPC_ID=vpc-74f9131e

#go to https://eu-central-1.console.aws.amazon.com/vpc/home?region=eu-central-1#subnets:
SUBNET1=subnet-8637e5ec
SUBNET2=subnet-f8aeb2b5
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
