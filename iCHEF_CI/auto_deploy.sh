#!/bin/bash -x

ICHEF_APP="iCHEF.ipa"
sleep 1

cd ~/output/ipa/rc
#cd ~/output/ipa
mv iCHEF2.ipa iCHEF.ipa

sleep 1

ios-deploy --bundle $ICHEF_APP



