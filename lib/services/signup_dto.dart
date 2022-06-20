import 'dart:convert';

import 'package:gb_pay_mobile/models/signup/signup_model.dart';
import 'package:gb_pay_mobile/util/constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SignupDTO {
  Future<SignupModel> signup(String nome, String cpf, String senha,
      String email, String endereco) async {
    final response = await http.post(Uri.parse('$serverURL/auth'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(<String, String>{
          'nome': nome,
          'cpf': cpf,
          'senha': senha,
          'email': email,
          'endereco': endereco,
        }));

    if (response.statusCode == 200) {
      print(response.body);
      return SignupModel.fromJson(jsonDecode(response.body));
    } else {
      print(response.body);
      throw Exception('Failed to signup');
    }
    
  }
}
