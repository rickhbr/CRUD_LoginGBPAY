import 'package:shared_preferences/shared_preferences.dart';

class CreditCardPreferencs {
  static late SharedPreferences _preferences;

  static const _keyCardNumber = 'cardNumber';
  static const _keyCardHolder = 'cardHolder';
  static const _keyCardHolderDocument = 'cardHolderDocument';
  static const _keyExpirationMonth = 'expirationMonth';
  static const _keyExpirationYear = 'expirationYear';
  static const _keySecurityCode = 'securityCode';
  static const _keyBrand = 'brand';
  static const _keyAmount = 'amount';
  static const _keyAmountOrigin = 'amountOrigin';
  static const _keyAmountDouble = 'amountDouble';
  static const _keyInstallments = 'installments';
  static const _keyDocumentNumber = 'documentNumber';
  static const _keyParcel = 'parcel';
  static const _keyCardHolderDocumentUnformated = 'cardHolderDocumentUnformated';

  static Future init() async =>
    _preferences = await SharedPreferences.getInstance();

  static Future setCardNumber(String cardNumber) async =>
  await _preferences.setString(_keyCardNumber, cardNumber);

  static Future setCardHolder(String cardHolder) async =>
  await _preferences.setString(_keyCardHolder, cardHolder);

  static Future setCardHolderDocument(String cardHolderDocument) async =>
  await _preferences.setString(_keyCardHolderDocument, cardHolderDocument);

  static Future setExpirationMonth(int expirationMonth) async =>
  await _preferences.setString(_keyExpirationMonth, expirationMonth.toString());

  static Future setExpirationYear(int expirationYear) async =>
  await _preferences.setString(_keyExpirationYear, expirationYear.toString());

  static Future setSecurityCode(String securityCode) async =>
  await _preferences.setString(_keySecurityCode, securityCode);

  static Future setBrand(String brand) async =>
  await _preferences.setString(_keyBrand, brand);

  static Future setAmount(int amount) async =>
  await _preferences.setString(_keyAmount, amount.toString());

 static Future setAmountDouble(String amountDouble) async =>
  await _preferences.setString(_keyAmountDouble, amountDouble.toString());

  static Future setAmountOrigin(String amountOrigin) async =>
  await _preferences.setString(_keyAmountOrigin, amountOrigin.toString());

  static Future setInstallments(int installments) async =>
  await _preferences.setString(_keyInstallments, installments.toString());

  static Future setDocumentNumber(String documentNumber) async =>
  await _preferences.setString(_keyDocumentNumber, documentNumber);

  static Future setParcel(double parcel) async =>
  await _preferences.setString(_keyParcel, parcel.toString());

  static Future setCardHolderDocumentUnformated(String cardHolderDocumentUnformated) async =>
  await _preferences.setString(_keyCardHolderDocumentUnformated, cardHolderDocumentUnformated);

  static String? getCardNumber() => _preferences.getString(_keyCardNumber);
  static String? getCardHolder() => _preferences.getString(_keyCardHolder);
  static String? getCardHolderDocument() => _preferences.getString(_keyCardHolderDocument);
  static String? getExpirationMonth() => _preferences.getString(_keyExpirationMonth);
  static String? getExpirationYear() => _preferences.getString(_keyExpirationYear);
  static String? getSecurityCode() => _preferences.getString(_keySecurityCode);
  static String? getBrand() => _preferences.getString(_keyBrand);
  static String? getAmount() => _preferences.getString(_keyAmount);
  static String? getAmountDouble() => _preferences.getString(_keyAmountDouble);
  static String? getAmountOrigin() => _preferences.getString(_keyAmountOrigin);
  static String? getInstallments() => _preferences.getString(_keyInstallments);
  static String? getDocumentNumber() => _preferences.getString(_keyDocumentNumber);
  static String? getParcel() => _preferences.getString(_keyParcel);
  static String? getCardHolderDocumentUnformated() => _preferences.getString(_keyCardHolderDocumentUnformated);
}