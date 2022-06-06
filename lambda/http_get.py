import json
import requests

URL = 'https://www.google.com/'
def lambda_handler(event, context):
    url = event[URL]
    response = requests.get(url)

    print(json.dumps(response))

response = requests.get(URL)

print(
    response
)