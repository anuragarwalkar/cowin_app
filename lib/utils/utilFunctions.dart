import 'package:cowin_app/storage/localStorage.dart';

get isTokenValid async {
  String savedTokenDate = ls.getMap('token_time');

  if (savedTokenDate != null) {
    DateTime savedDate = DateTime.parse(savedTokenDate);
    bool isValid = DateTime.now().difference(savedDate).inMinutes <= 10;
    if (isValid) {
      return isValid;
    } else {
      ls.removeToken();
    }
  }

  return false;
}
