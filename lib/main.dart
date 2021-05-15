import 'package:cowin_app/my_app.dart';
import 'package:cowin_app/screens/first_screen.dart';
import 'package:cowin_app/screens/home_screen.dart';
import 'package:cowin_app/storage/localStorage.dart';
import 'package:cowin_app/utils/utilFunctions.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ls.init();
  String initialRoute =
      await isTokenValid ? HomeScreen.routeName : FirstScreen.routeName;
  runApp(
    MyApp(initialRoute),
  );
}
