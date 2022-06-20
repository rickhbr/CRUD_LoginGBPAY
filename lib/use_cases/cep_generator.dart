import 'package:flutter/material.dart';
import 'package:via_cep_flutter/via_cep_flutter.dart';

Future<void> readyCep(String cep) async {
  final result = await readAddressByCep(cep); //Cep inválido!

  if (result.isEmpty) return;

  // controllerCidade = result['city'];
  // controllerBairro = result['neighborhood'];
  // controllerRua = result['street'];
}
