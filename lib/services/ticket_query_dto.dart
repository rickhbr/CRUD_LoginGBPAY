import 'dart:convert';

import 'package:gb_pay_mobile/models/ticket_query/ticket_query.dart';
import 'package:gb_pay_mobile/util/constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class TicketQueryDTO {
  Future<TicketQuery> ticketQuery(
    int type,
    String codebarDigitable,
    String barCode,
  ) async {
    final String token;
    final String userId;

    try {
      final prefs = await SharedPreferences.getInstance();
      token = prefs.getString('token')!;
      userId = prefs.getString('userId')!;
    } on Exception catch (e) {
      print(e.toString());
      throw Exception(e.toString());
    }

    final response = await http.post(
      Uri.parse('$serverURL/pagamentos/consulta'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(
        {
          'externalTerminal': userId, //id do usuario
          'externalNSU': 0,
          'barCode': {
            // tipo do boleto, se o codigo de barras começar com 8 o tipo é 1, com 8 é conta de luz, agua
            // tipo 2 é tipo banco
            'type': type,
            'digitable': codebarDigitable,
            'barCode': barCode
          }
        },
      ),
    );

    if (response.statusCode == 200) {
      print(response.body);
      return TicketQuery.fromJson(jsonDecode(response.body));
    } else {
      print(response.body);
      throw Exception('Failed to query ticket');
    }
  }
}
