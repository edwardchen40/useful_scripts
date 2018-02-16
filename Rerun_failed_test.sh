#!/bin/sh

# This script file is to re-execute test cases and merge test result on Robot framework
# usage: ./run_robot.sh any_robot_command test_suite
# note: cannot execute command within ', ex. -t 'test case'
# Reference: http://laurent.bristiel.com/re-executing-failed-test-cases-and-merging-outputs-with-robot-framework/

UPDATE_TESTRAIL_SCRIPT="python ../common/testrail/update_robot_test_result_to_testrail.py --folder=$RESULT_REPORT --pid=4 --user=xxx --pwd='xxx' --runid=${GLN_RUN_ID}"

# clean previous output files
rm -rf $RESULT_REPORT

if [ -z "$NUMBER_OF_PROCESSOR" ]; then
    NUMBER_OF_PROCESSOR=1
fi
 
echo
STARTTIME=$(date +%s)
echo $STARTTIME
echo "#######################################"
echo "# Running portfolio a first time      #"
echo "#######################################"
echo
pabot --processes $NUMBER_OF_PROCESSOR -d $RESULT_REPORT -e retire -L debug $@
res=$?

# we stop the script here if all the tests were OK
if [ $res -eq 0 ]; then
    echo "The first run is done."
    echo $UPDATE_TESTRAIL_SCRIPT
    exit 0
fi
# otherwise we go for another round with the failing tests

# we launch the tests that failed
echo
date
echo "#######################################"
echo "# Running again the tests that failed #"
echo "#######################################"
echo

pabot --processes $NUMBER_OF_PROCESSOR -d $RESULT_REPORT --rerunfailed $RESULT_REPORT/output.xml --output rerun.xml -e retire -L debug $@
res=$?

ENDTIME=$(date +%s)
echo "It takes $(($ENDTIME - $STARTTIME)) seconds to complete this task..."

# Merging output files
echo
date
echo "########################"
echo "# Merging output files #"
echo "########################"
echo
# Robot Framework generates a new output.xml
rebot --nostatusrc --outputdir $RESULT_REPORT --output output.xml --merge $RESULT_REPORT/output.xml  $RESULT_REPORT/rerun.xml

if [ $res -eq 0 ]; then
    echo "The second re-run is done."
    echo $UPDATE_TESTRAIL_SCRIPT
    exit 0
fi
