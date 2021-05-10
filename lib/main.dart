import 'package:cowin_app/screens/first_screen.dart';
import 'package:cowin_app/screens/home_screen.dart';
import 'package:cowin_app/screens/login_confirmation_screen.dart';
import 'package:cowin_app/storage/localStorage.dart';
import 'package:cowin_app/utils/colors.dart';
import 'package:cowin_app/utils/utilFunctions.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ls.init();
  String initialRoute = await isTokenValid
      ? HomeScreen.routeName
      : ls.getInt('phone') != null
          ? LoginConfirmationScreen.routeName
          : FirstScreen.routeName;
  runApp(MyApp(initialRoute));
}

class MyApp extends StatelessWidget {
  final String initalRoute;
  MyApp(this.initalRoute);
  final String title = 'Cowin App';
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      theme: ThemeData(
        primarySwatch: colorCustom,
        fontFamily: 'Lato',
      ),
      initialRoute: initalRoute,
      routes: {
        FirstScreen.routeName: (ctx) => FirstScreen(),
        LoginConfirmationScreen.routeName: (ctx) => LoginConfirmationScreen(),
        HomeScreen.routeName: (ctx) => HomeScreen()
      },
    );
  }
}
