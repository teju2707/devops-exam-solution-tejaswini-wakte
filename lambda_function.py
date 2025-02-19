import json
import os
import requests

def lambda_handler(event, context):
    subnet_id = os.getenv('SUBNET_ID')
    payload = {
        "subnet_id": subnet_id,
        "name": "Your Full Name",
        "email": "your.email@example.com"
    }
    headers = {
        'X-Siemens-Auth': 'test'
    }
    response = requests.post("https://bc1yy8dzsg.execute-api.eu-west-1.amazonaws.com/v1/data", json=payload, headers=headers)
    return {
        'statusCode': response.status_code,
        'body': response.text
    }
