# InjectDylib
Inject dylib library into iOS App

To inject dylib library into iOS App (.ipa), its not just copy dylib into Frameworks folder. But you need to inject into binary to be able to load your dylib during app startup.

The tools to inject it, it's called optool : https://github.com/alexzielenski/optool 

You can test the sample of dylib from pokemon hook project : https://github.com/rpplusplus/PokemonHook

# Inject using Optool
This is the sample of using optool : 

../template/optool install -c load -p "@executable_path/Frameworks/libLocationFaker.dylib" -t "./Payload/SampleNOF.app/SampleNOF" >& /dev/null

Before run that command, you need to make sure, libLocationFaker.dylib already copied to this path Sample.app/Frameworks/libLocationFaker.dylib

cp ./SwiftSupport/iphoneos/**.dylib Payload/SampleNOF.app/Frameworks/


