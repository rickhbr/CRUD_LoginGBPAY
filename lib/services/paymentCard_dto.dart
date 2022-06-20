import 'dart:convert';

import 'package:gb_pay_mobile/models/paymentCard/paymentCard_model.dart';
import 'package:gb_pay_mobile/models/signin/signin_model.dart';
import 'package:gb_pay_mobile/models/signup/signup_model.dart';
import 'package:gb_pay_mobile/services/signin_dto.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class PaymentCardDTO {
  Future<PaymentCardModel> payment(jsonBody) async {
    final response = await http.post(
      Uri.parse(
          'https://mqzvn3zk5c.execute-api.sa-east-1.amazonaws.com/beta/authorize'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(jsonBody),
    );
    if (response.statusCode == 200) {
      print(response.body);
      return PaymentCardModel.fromJson(jsonDecode(response.body));
    } else {
      print(response.body);
      throw Exception('Failed to payment');
    }
  }
}
