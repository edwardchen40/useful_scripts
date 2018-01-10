#!/bin/sh

# This script file is to re-execute test cases and merge test result on Robot framework
# usage: ./run_robot.sh any_robot_command test_suite
# note: cannot execute command within ', ex. -t 'test case'
# Reference: http://laurent.bristiel.com/re-executing-failed-test-cases-and-merging-outputs-with-robot-framework/

UPDATE_TESTRAIL_SCRIPT="python ../common/testrail/update_robot_test_result_to_testrail.py --folder=$RESULT_REPORT --pid=4 --user=jpt0070@linecorp.com --pwd='line12#$' --runid=${GLN_RUN_ID}"

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



// ===== 分隔線 ====
// In Jenjins , Execute Shell

CHROMEDRIVER_ABS_PATH=`cd util-lib; pwd`
export PATH=$PATH:$CHROMEDRIVER_ABS_PATH:/usr/local/bin

set +e

cd gln

export RESULT_REPORT=pc_report_remote
export NUMBER_OF_PROCESSOR=3
./glbot ${tag} -V env/${env}.py:TW -v DELAY:0.6 -v VALID_USER:jpt0070 -v VALID_PASSWORD:line12#$ -e timeline pc/

export RESULT_REPORT=pc_report_timeline
export NUMBER_OF_PROCESSOR=1
./glbot ${tag} -V env/${env}.py:TW -v DELAY:0.6 -v VALID_USER:jpt0070 -v VALID_PASSWORD:line12#$ -i timeline pc/

#pabot --processes 4 -d pc_report_remote -V env/${env}.py:TW -v DELAY:1 -v VALID_USER:jpt0070 -v VALID_PASSWORD:'line12#$' -e retire -e timeline ${tag} -L debug pc/
#pybot -d pc_report_timeline -V env/${env}.py:TW -v DELAY:0.5 -v VALID_USER:jpt0070 -v VALID_PASSWORD:'line12#$' -i timeline -L debug pc/

set -e

rebot --outputdir pc_report --output output.xml pc_report_remote/output.xml pc_report_timeline/output.xml

#cd ..
#python common/testrail/update_robot_test_result_to_testrail.py --folder=gln/pc_report --pid=4 --user=jpt0070@linecorp.com --pwd='line12#$' --runid=${GLN_RUN_ID}
