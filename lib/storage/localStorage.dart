import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  SharedPreferences _prefs;
  // final bool _isLoginSscreen = false;

  init() async {
    return _prefs = await SharedPreferences.getInstance();
  }

  Future<bool> setMap(String key, String value) async {
    if (_prefs != null) {
      return await _prefs.setString(key, value);
    }

    return null;
  }

  Future<bool> setInt(String key, int value) async {
    if (_prefs != null) {
      return await _prefs.setInt(key, value);
    }

    return null;
  }

  String getMap(String key) {
    if (_prefs != null) {
      return _prefs.getString(key);
    }

    return null;
  }

  int getInt(String key) {
    if (_prefs != null) {
      return _prefs.getInt(key);
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
