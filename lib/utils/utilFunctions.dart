import 'package:cowin_app/storage/localStorage.dart';
import 'package:intl/intl.dart';

get formatedDate {
  final DateFormat formatter = DateFormat('dd-MM-yyyy');
  return formatter.format(DateTime.now());
}

get isTokenValid async {
  String savedTokenDate = ls.getMap('token_time');

  if (savedTokenDate != null) {
    DateTime savedDate = DateTime.parse(savedTokenDate);
    int diffInTime = DateTime.now().difference(savedDate).inMinutes;

    if (diffInTime <= 14) {
      return true;
    } else {
      ls.removeToken();
    }
  }

  return false;
}
