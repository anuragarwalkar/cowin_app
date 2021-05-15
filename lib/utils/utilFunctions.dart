import 'package:cowin_app/storage/localStorage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

get formatedDate {
  final DateFormat formatter = DateFormat('dd-MM-yyyy');
  return formatter.format(DateTime.now());
}

get tokenTimeDiff {
  String savedTokenDate = ls.getMap('token_time');
  if (savedTokenDate != null) {
    DateTime savedDate = DateTime.parse(savedTokenDate);
    return DateTime.now().difference(savedDate).inSeconds;
  }

  return null;
}

get isTokenValid async {
  if (tokenTimeDiff != null) {
    if (tokenTimeDiff <= 840) {
      return true;
    } else {
      ls.removeToken();
    }
  }

  return false;
}

void showSnackbar({@required String message, @required BuildContext context}) {
  final snackBar = SnackBar(content: Text(message));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
