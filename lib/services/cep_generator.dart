import 'package:http/http.dart' as http;

import '../models/cep_result_model.dart';

class ViaCepService {
  static Future<ResultCep> fetchCep({String? cep}) async {
    final response = await http.get(Uri.parse('https://viacep.com.br/ws/$cep/json/'));
    if (response.statusCode == 200) {
      return ResultCep.fromJson(response.body);
    }else if(cep == ''){
     throw Exception('Requisição não pode ser vazia');
    } 
    else {
      throw Exception('Requisição inválida!');
    }
  }
}