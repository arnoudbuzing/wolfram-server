import requests

url = 'http://127.0.0.1:5858'

post = '''
WolframAlpha["population of the netherlands", "Result"]
'''

r = requests.post(url=url, data=post)

print('result: ' + r.text)

