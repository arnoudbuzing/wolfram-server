import sys
import requests

url = 'http://127.0.0.1:5858'

r = requests.post(url=url, data=sys.argv[1])

print('result: ' + r.text)

