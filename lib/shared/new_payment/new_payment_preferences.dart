import 'package:shared_preferences/shared_preferences.dart';

class NewPaymentPreferencs {
  static late SharedPreferences _preferences;

  static const _keyAssignor = 'assignor';
  static const _keyRegisterData = 'registerData';
  static const _keyTransactionId = 'transactionId';

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setAssignor(String? assignor) async =>
      await _preferences.setString(_keyAssignor, assignor!);


  static Future setTransactionId(int? transactionId) async =>
      await _preferences.setString(_keyTransactionId, transactionId.toString());

  static String?  getAssignor() => _preferences.getString(_keyAssignor);
  static String? getRegisterData() => _preferences.getString(_keyRegisterData);
  static String? getTransactionId() => _preferences.getString(_keyTransactionId);
}