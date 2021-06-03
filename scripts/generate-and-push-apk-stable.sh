#!/bin/bash

# Please give your path of source files 
read -p "Press any key to continue pushing android app to Anurag Drive..."

cd ..
cd "build/app/outputs/flutter-apk"
flutter build apk 
mv -f "app-release.apk" "$HOME/Google Drive/Mobile App/Co-WIN_App.apk"

flutter build apk --split-per-abi
mv -f "app-x86_64-release.apk" "$HOME/Google Drive/Mobile App/app-x86_64-release.apk"
mv -f "app-armeabi-v7a-release.apk" "$HOME/Google Drive/Mobile App/app-armeabi-v7a-release.apk"
mv -f "app-arm64-v8a-release.apk" "$HOME/Google Drive/Mobile App/app-arm64-v8a-release.apk"

echo "File copied successfully to Drive"
read -p "Press any Key to exit..."
