rm -rf Payload
rm -rf SampleNOF-Signed.ipa
unzip -q SampleNOF.ipa
rm -rf __MACOSX
rm -rf Payload/SwiftSupport

find . -name '.DS_Store' -type f -delete

#read -p "enter to continue"

rm -rf Payload/SampleNOF.app/_CodeSignature

#read -p "enter to continue"

cp embedded.mobileprovision Payload/SampleNOF.app/embedded.mobileprovision

cp ./SwiftSupport/iphoneos/**.dylib Payload/SampleNOF.app/Frameworks/

cp -a ./SwiftSupport/iphoneos/LocationSpoofing.framework Payload/SampleNOF.app/Frameworks/

../template/optool install -c load -p "@executable_path/Frameworks/libLocationFaker.dylib" -t "./Payload/SampleNOF.app/SampleNOF" >& /dev/null

read -p "enter to continue"

codesign -f -s "iPhone Distribution: ENETS PTE. LTD. (2YU75YNV6V)" Payload/SampleNOF.app/Frameworks/*

rm -rf Payload/SampleNOF.app/libswiftRemoteMirror.dylib

codesign -d -vv --entitlements entitlements.plist Payload/SampleNOF.app/SampleNOF
#read -p "enter to continue"
#cp ../template/UAT/entitlements.plist entitlements.plist
codesign -vfs "iPhone Distribution: ENETS PTE. LTD. (2YU75YNV6V)" --entitlements entitlements.plist Payload/SampleNOF.app
find . -name '.DS_Store' -type f -delete
rm entitlements.plist
zip -r --symlinks SampleNOF-Signed.ipa * -x *.sh* -x *.mobileprovision* -x *.ipa*

#Deploy to device
ios-deploy --bundle ./SampleNOF-Signed.ipa
