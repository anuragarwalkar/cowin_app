import 'package:cowin_app/screens/first_screen.dart';
import 'package:cowin_app/screens/home_screen.dart';
import 'package:cowin_app/screens/login_confirmation_screen.dart';
import 'package:cowin_app/utils/colors.dart';
import 'package:flutter/material.dart';

class MyApp extends StatefulWidget {
  final String initalRoute;
  MyApp(this.initalRoute);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  final String title = 'Cowin App';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      theme: ThemeData(
        primarySwatch: colorCustom,
        fontFamily: 'Lato',
      ),
      initialRoute: widget.initalRoute,
      routes: {
        FirstScreen.routeName: (ctx) => FirstScreen(),
        LoginConfirmationScreen.routeName: (ctx) => LoginConfirmationScreen(),
        HomeScreen.routeName: (ctx) => HomeScreen()
      },
    );
  }
}
