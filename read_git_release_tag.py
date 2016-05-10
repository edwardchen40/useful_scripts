from subprocess import call
#import pdb

#pdb.set_trace()
call("git tag -l 2.5.0.* > newtag.txt", shell=True) # with an args list and shell=False (the default) does not use a shell.

# Read old tags from old tag file
linesOld = [line.rstrip('\n') for line in open('oldtag.txt')]
oldTag = linesOld[-1]

# Read latest tags from latest file
linesNew = [line.rstrip('\n') for line in open('newtag.txt')]
newTag = linesNew[-1]

# Compare the tags between old and latest tag files

if oldTag != newTag :
	call(['git', 'checkout', 'tags/' + newTag])
	call(['mv', 'newtag.txt', 'oldtag.txt'])	
	print "================================================"
	print "= Now the release branch tag is" + newTag + " ="
	print "================================================"
else:
	print "========================================"
	print "= Here is not a latest release version ="
	print "========================================"
