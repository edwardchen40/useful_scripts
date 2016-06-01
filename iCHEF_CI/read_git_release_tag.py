#!/usr/bin/python
# -*- coding: utf-8 -*-

from subprocess import call
import os

#import pdb
#pdb.set_trace()
call("cp ~/OldTag.txt ~/iCHEF-2.0/", shell=True)
#call("cp ~/OldTag.txt ~/iCHEF-2.0/", shell=True)
#call("cp ~/read_release_tag.py ~/iCHEF-2.0/", shell=True)
call("git tag -l 2.5.* > NewTag.txt", shell=True)

# Read old tags from old tag file
linesOld = [line.rstrip('\n') for line in open('OldTag.txt')]
oldTag = linesOld[-1]

# Read latest tags from latest file
linesNew = [line.rstrip('\n') for line in open('NewTag.txt')]
newTag = linesNew[-1]

# Compare the tags between old and latest tag files

if oldTag != newTag :
    call("cp NewTag.txt ~/OldTag.txt", shell=True)
    call(['git', 'add', '-A'])
    call(['git', 'commit', '-am', '\"There will be checkout to another brance.\"'])
    call(['git', 'checkout', 'tags/' + newTag])
    print "================================================"
    print "= Now the release branch tag is" + newTag + " ="
    print "================================================"
#    call("cd ~;cp ~/tmp_files/Appfile ~/iCHEF-2.0/fastlane/")
#    call("cd ~;cp ~/tmp_files/Fastfile ~/iCHEF-2.0/fastlane/")
#    call('~/auto_build.sh', shell=True)
#    call('~/auto_deploy.sh',shell=True)
else:
    print "========================================"
    print "= Here is not a latest release version ="
    print "========================================"

