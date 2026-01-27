
import 'package:riderapp/core/constant/app_constants.dart';

import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static const _key = AppConstants.authTokenKey;
  // static int count = 0;

  static Future<String?> load() async {
    final prefs = await SharedPreferences.getInstance();

    final code = prefs.getString(_key);

    return code;
  }

  static Future<void> save(String token) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(_key, token);
  }

  static Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(_key);
  }
}
