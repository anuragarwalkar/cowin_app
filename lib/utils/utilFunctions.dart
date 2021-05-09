import 'package:cowin_app/storage/localStorage.dart';

get isTokenValid {
  String savedTokenDate = ls.getMap('token_time');

  if (savedTokenDate != null) {
    DateTime savedDate = DateTime.parse(savedTokenDate);
    return DateTime.now().difference(savedDate).inMinutes <= 10;
  }

  return false;
}
