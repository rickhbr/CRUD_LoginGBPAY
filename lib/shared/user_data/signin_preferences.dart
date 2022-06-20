import 'package:shared_preferences/shared_preferences.dart';

class UserPreferencs {
  static late SharedPreferences _preferences;

  static const _keyToken = 'token';
  static const _keyUserName = 'userName';
  static const _keyUserId = 'userId';

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setToken(String? token) async =>
      await _preferences.setString(_keyToken, token!);

  static Future setUserName(String? name) async =>
      await _preferences.setString(_keyUserName, name!);

  static Future setUserId(int? id) async =>
      await _preferences.setString(_keyUserId, id.toString());

  static String? getToken() => _preferences.getString(_keyToken);
  static String? getUserName() => _preferences.getString(_keyUserName);
  static String? getId() => _preferences.getString(_keyUserId);

}
