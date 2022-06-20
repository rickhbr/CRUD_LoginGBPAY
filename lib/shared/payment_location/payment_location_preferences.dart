import 'package:shared_preferences/shared_preferences.dart';

class PaymentLocationPreferencs {
  static late SharedPreferences _preferences;

  static const _keyUF = 'uf';
  static const _keyCep = 'cep';
  static const _keyBairro = 'bairro';
  static const _keyEndereco = 'endereco';
  static const _keyNumero = 'numero';
  static const _keyComplemento = 'complemento';
  static const _keyCidade = 'cidade';

  static Future init() async =>
    _preferences = await SharedPreferences.getInstance();

  static Future setUf(String uf) async =>
  await _preferences.setString(_keyUF, uf);

  static Future setCep(String cep) async =>
  await _preferences.setString(_keyCep, cep);

  static Future setBairro(String bairro) async =>
  await _preferences.setString(_keyBairro, bairro);

  static Future setEndereco(String endereco) async =>
  await _preferences.setString(_keyEndereco, endereco);

  static Future setNumero(String numero) async =>
  await _preferences.setString(_keyNumero, numero);

  static Future setComplemento(String complemento) async =>
  await _preferences.setString(_keyComplemento, complemento);

  static Future setCidade(String cidade) async =>
  await _preferences.setString(_keyCidade, cidade);

  static String? getUf() => _preferences.getString(_keyUF);
  static String? getCep() => _preferences.getString(_keyCep);
  static String? getBairro() => _preferences.getString(_keyBairro);
  static String? getEndereco() => _preferences.getString(_keyEndereco);
  static String? getNumero() => _preferences.getString(_keyNumero);
  static String? getComplemento() => _preferences.getString(_keyComplemento);
  static String? getCidade() => _preferences.getString(_keyCidade);
}