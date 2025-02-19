#!/bin/bash

# Create a deployment package for the Lambda function
mkdir -p package
pip install --target ./package -r requirements.txt
cp lambda_function.py package/
cd package
zip -r ../lambda_function_payload.zip .
cd ..
rm -rf package
