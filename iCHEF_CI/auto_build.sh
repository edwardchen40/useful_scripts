#!/bin/bash -x

cd ~/iCHEF-2.0
tag=$(git tag -l '2.5.*' | tail -n 2 | head -n 1)

cd ~/output/ipa/rc
#cd ~/output/ipa/

# backup the old ipa 
cp iCHEF.ipa ~/output/ipa/old_build/${tag}_iCHEF.ipa

# Clear the ipa folder
rm -rf *.*
sleep 1

cd ~/iCHEF-2.0

#if [ -d fastlane ]; then fastlane ios build_DEV
if [ -d fastlane ]; then fastlane ios build_RC
else
    fastlane init
    cd ~/iCHEF-2.0/fastlane
    rm -rf ./*.*
    cp ~/tmp_files/Appfile ./
    cp ~/tmp_files/Fastfile ./
fi




