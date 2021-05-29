import 'package:cowin_app/my_app.dart';
import 'package:cowin_app/screens/first_screen.dart';
import 'package:cowin_app/screens/home_screen.dart';
import 'package:cowin_app/storage/localStorage.dart';
import 'package:cowin_app/utils/utilFunctions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await DotEnv.load(fileName: ".env");
  } catch (e) {
    throw Exception("Please include .env file in the root of the app");
  }
  await ls.init();
  String initialRoute =
      await isTokenValid ? HomeScreen.routeName : FirstScreen.routeName;
  runApp(
    MyApp(initialRoute),
  );
}
