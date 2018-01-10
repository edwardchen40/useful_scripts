#!/bin/sh
# This script file is to re-execute test cases and merge test result on Robot framework
# usage: ./run_robot.sh any_robot_command test_suite
# note: cannot execute command within ', ex. -t 'test case'
# Reference: http://laurent.bristiel.com/re-executing-failed-test-cases-and-merging-outputs-with-robot-framework/

# clean previous output files
rm -f report/output.xml
rm -f report/rerun.xml
rm -f report/first_run_log.html
rm -f report/second_run_log.html
rm -f report/xunit.xml

run_with_tag=''

if [ ! -z "$TAG" ]; then
    run_with_tag='-i '$TAG
fi
 
echo
echo "#######################################"
echo "# Running portfolio a first time      #"
echo "#######################################"
echo
pybot $run_with_tag -x xunit.xml --outputdir report $@
res=$?

# we stop the script here if all the tests were OK
if [ $res -eq 0 ]; then
    echo "we don't run the tests again as everything was OK on first try"
    exit 0  
fi
# otherwise we go for another round with the failing tests
 
# we keep a copy of the first log file
cp report/log.html  report/first_run_log.html
 
# we launch the tests that failed
echo
echo "#######################################"
echo "# Running again the tests that failed #"
echo "#######################################"
echo
pybot --outputdir report --rerunfailed report/output.xml -x xunit.xml --output rerun.xml $@
res=$?
# Robot Framework generates file rerun.xml

if [ $res -ne 0 ]; then
    RES=true
fi
 
# we keep a copy of the second log file
cp report/log.html  report/second_run_log.html
 
# Merging output files
echo
echo "########################"
echo "# Merging output files #"
echo "########################"
echo
rebot --nostatusrc --outputdir report --output output.xml --merge report/output.xml  report/rerun.xml
# Robot Framework generates a new output.xml

if [ $RES ]; then
    exit 1  
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
