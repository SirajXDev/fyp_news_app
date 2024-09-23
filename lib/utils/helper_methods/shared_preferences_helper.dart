import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  final SharedPreferences _prefs;
  SharedPreferencesHelper(this._prefs);

  // Set string value

  Future<void> setString(String key, String value) async {
    await _prefs.setString(key, value);
  }

  // Get string value

  String? getString(String key) {
    return _prefs.getString(key);
  }

  // Remove value

  Future<void> removeString(String key) async {
    await _prefs.remove(key);
  }

  // Clear all values

  Future<void> clearString() async {
    await _prefs.clear();
  }
}
