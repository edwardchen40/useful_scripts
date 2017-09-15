import requests
import sys
from sys import argv

if len(argv) is not 5:
    print("Usage: python line_notify.py <token> <description> <job name> <job url>")
    sys.exit(-1)

url = "https://notify-api.line.me/api/notify"
header = {"Authorization": "Bearer {}".format(argv[1])}
message = {"message": "{}\nJob: {}\nURL: {}".format(argv[2], argv[3], argv[4])}
print(message)

result = requests.post(url, data=message, headers=header)
print(result)
