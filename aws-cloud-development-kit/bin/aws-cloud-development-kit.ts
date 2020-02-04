#!/usr/bin/env node
import 'source-map-support/register';
import * as cdk from '@aws-cdk/core';
import { AwsCloudDevelopmentKitStack } from '../lib/aws-cloud-development-kit-stack';

const app = new cdk.App();
new AwsCloudDevelopmentKitStack(app, 'AwsCloudDevelopmentKitStack', {env: {region: 'eu-central-1', account: '806803862815'}});
