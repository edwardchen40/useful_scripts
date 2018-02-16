#!/usr/bin/python

import json 
import sys 
import urllib2
import base64
import subprocess
import requests

jenkinsUrl = "http://my_url:8080/job/"
username = ""
password = ""
iftttUrl = ""

if len( sys.argv ) > 1 : 
    jobName = sys.argv[1]
else :
    print "Please supply a job name from Jenkins server." 
    print "EX: python get_jenkins_result.py GLN_automatic_Health_check_Beta"
    sys.exit(1)

# Step 1 - Connect to Jenkons then get json file
try:
    #jenkinsStream = urllib2.urlopen( jenkinsUrl + jobName + "/lastBuild/api/json" ) # No user login
    request = urllib2.Request(jenkinsUrl + jobName + "/lastBuild/api/json") # User login method
    base64string = base64.encodestring('%s:%s' % (username, password)).replace('\n', '')
    request.add_header("Authorization", "Basic %s" % base64string)   
    result = urllib2.urlopen(request)

except urllib2.HTTPError, e:
    print "URL Error: " + str(e.code) 
    print "      (job name [" + jobName + "] probably wrong)"
    sys.exit(2)


# Step 2 - Query final committer
committerName = subprocess.check_output("GIT_NAME=$(git --no-pager show -s --format='%an' $GIT_COMMIT)&&echo $GIT_NAME", shell=True)

# Step 3 - Get Json file
try:
    #buildStatusJson = json.load( jenkinsStream )
    buildStatusJson = json.load( result )
except:
    print "Failed to parse json"
    sys.exit(3)

# Step 4 - Prepare sending value you want
fullDisplayName = buildStatusJson["fullDisplayName"]
fullUrlPath = buildStatusJson["url"]

# Debug 
#print json.dumps(buildStatusJson, indent=4, sort_keys=True)
#for key, value in buildStatusJson.items():
   # print("key:" + key)
   
# Step 5 - Send request to IFTTT
if buildStatusJson.has_key( "result" ): 
    #print json.dumps(buildStatusJson, indent=4, sort_keys=True) 
    #print "[" + jobName + "] build status: " + buildStatusJson["result"]
    if buildStatusJson["result"] != "SUCCESS" :
        headers = {"Content-Type": "application/json"}
        data = {"value1": fullDisplayName, "value2": committerName, "value3": fullUrlPath}
        response = requests.post(url=iftttUrl, json=data, headers=headers)
        print (response.status_code , response.reason )
        exit(4)
    else:
        sys.exit(5)

sys.exit(0)
