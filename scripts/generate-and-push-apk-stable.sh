#!/bin/bash

# Please give your path of source files 
read -p "Press any key to continue pushing android app to Anurag Drive..."
flutter build apk
mv -f "C:/projects/my_projects/cowin_app/build/app/outputs/flutter-apk/app-release.apk" "C:/Users/AnuragArwalkar/Google Drive/Mobile App/Co-WIN_App.apk"
echo "File copied successfully to Drive"
read -p "Press any Key to exit..."
