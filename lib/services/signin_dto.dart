import 'dart:convert';

import 'package:gb_pay_mobile/models/signin/signin_model.dart';
import 'package:gb_pay_mobile/util/constants.dart';
import 'package:http/http.dart' as http;

class SigninDTO {
  Future<SigninModel> signin(String email, String password) async {
    final response = await http.post(
      Uri.parse('$serverURL/auth/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(<String, String>{
        "email": email,
        "senha": password,
      }),
    );

    if (response.statusCode == 200) {
      print(response.body);
      return SigninModel.fromJson(jsonDecode(response.body));
    } else {
      print(response.body);
      throw Exception('Failed to load cliente');
    }
  }
}
