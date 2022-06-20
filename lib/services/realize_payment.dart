// import 'dart:convert';

// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';

// class RealizePaymentQuery {
//   Future<RealizePaymentModel> payment(
//     int nsu,
//     String externalTerminal,
//     String cpf,
//     double valueFee,
//     double originalValue,
//     //double valueWithAdditional,
//     String nome,
//     int typeBarCode,
//     String digitable,
//     String barCode,
//     DateTime dueDate,
//     int transactionIdAuthorize,
//     String corban,
//   ) async {
//     final String token;

//     try {
//       final prefs = await SharedPreferences.getInstance();
//       token = prefs.getString('token')!;
//     } on Exception catch (e) {
//       print(e.toString());
//       throw Exception(e.toString());
//     }

//     final response = await http.post(
//       Uri.parse('https://mqzvn3zk5c.execute-api.sa-east-1.amazonaws.com/beta/'),
//       headers: <String, String>{
//         'Content-Type': 'application/json',
//         'Authorization': 'Bearer $token',
//       },
//       body: jsonEncode({
//         {
//           "convenant": "string",
//           "externalNSU": nsu,
//           "externalTerminal": externalTerminal,
//           "cpfcnpj": cpf,
//           "billData": {
//             "value": valueFee,
//             "originalValue": originalValue,
//             "valueWithDiscount": 0,
//             "valueWithAdditional": valueFee - originalValue
//           },
//           "infoBearer": {
//             "nameBearer": nome,
//             "documentBearer": cpf,
//             "methodPaymentCode": 2
//           },
//           "barCode": {
//             "type": 2,
//             "digitable": digitable,
//             "barCode": barCode
//           },
//           "dueDate": dueDate,
//           "transactionIdAuthorize": transactionIdAuthorize,
//           "userType": 1,
//           "corban": corban
//         }
//       }),
//     );
//     if (response.statusCode == 200) {
//       print(response.body);
//       return RealizePaymentModel.fromJson(jsonDecode(response.body));
//     } else {
//       print(response.body);
//       throw Exception('Failed to query ticket');
//     }
//   }
// }
