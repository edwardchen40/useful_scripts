#!/usr/bin/python

import json 
import sys 
import urllib2

jenkinsUrl = "http://192.168.5.1:8080/job/"
#jenkinsUrl = "https://192.168.5.1:8080/job/Autotest/lastBuild/api/json"
#jenkinsUrl = "https://192.168.5.1:8080/job/Autotest/287/api/json" // you can use ID dierctly.


if len( sys.argv ) > 1 : 
    jobName = sys.argv[1]
else :
    sys.exit(1)

try:
    jenkinsStream = urllib2.urlopen( jenkinsUrl + jobName + "/lastBuild/api/json" )
    
except urllib2.HTTPError, e:
    print "URL Error: " + str(e.code) 
    print "      (job name [" + jobName + "] probably wrong)"
    sys.exit(2)

try:
    buildStatusJson = json.load( jenkinsStream )
except:
    print "Failed to parse json"
    sys.exit(3)

if buildStatusJson.has_key( "result" ):    
    print "[" + jobName + "] build status: " + buildStatusJson["result"]
    if buildStatusJson["result"] != "SUCCESS" :
        exit(4)
    else:
        sys.exit(5)

sys.exit(0)
