import 'package:flutter/material.dart';

const appBackgroundColor = Color.fromRGBO(17, 71, 102, 1);

const appPrimaryColor = Color.fromRGBO(0, 214, 202, 1);
Map<int, Color> _color = {
  50: Color.fromRGBO(0, 214, 202, .1),
  100: Color.fromRGBO(0, 214, 202, .2),
  200: Color.fromRGBO(0, 214, 202, .3),
  300: Color.fromRGBO(0, 214, 202, .4),
  400: Color.fromRGBO(0, 214, 202, .5),
  500: Color.fromRGBO(0, 214, 202, .6),
  600: Color.fromRGBO(0, 214, 202, .7),
  700: Color.fromRGBO(0, 214, 202, .8),
  800: Color.fromRGBO(0, 214, 202, .9),
  900: Color.fromRGBO(0, 214, 202, 1),
};
MaterialColor colorCustom = MaterialColor(0xFF00d6ca, _color);
