import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  SharedPreferences _prefs;

  init() async {
    return _prefs = await SharedPreferences.getInstance();
  }

  Future<bool> setMap(String key, String value) async {
    if (_prefs != null) {
      return await _prefs.setString(key, value);
    }

    return null;
  }

  String getMap(String key) {
    if (_prefs != null) {
      return _prefs.getString(key);
    }

    return null;
  }

  void removeToken() async {
    if (_prefs != null) {
      await _prefs.remove('token');
      await _prefs.remove('token_time');
    }
  }
}

LocalStorage ls = LocalStorage();
