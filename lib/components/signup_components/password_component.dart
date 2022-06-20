import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../util/colors.dart';

class FormInputsPass extends StatelessWidget {
  final TextEditingController controller;

  const FormInputsPass({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String confirmPass = '';
    return Column(
      children: [
        const Align(
          alignment: Alignment.topLeft,
          child: Text(
            'Senha',
            style: const TextStyle(
              fontSize: 16.0,
              color: Colors.black,
            ),
          ),
        ),
        const SizedBox(
          height: 12.0,
        ),
        TextFormField(
          validator: validatorPass,
          controller: controller,
          obscureText: true,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            contentPadding: const EdgeInsets.fromLTRB(2, 2, 2, 0),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 2, color: Colors.grey),
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          onChanged: (text) {
            confirmPass = text;
          },
        ),
        const SizedBox(
          height: 10.0,
        ),
      ],
    );
  }
    String? validatorPass(value) {
    if (value.isEmpty) {
      return 'Por favor, insira uma senha';
    } else if (value.length < 4) {
      return 'Sua senha deve ter no mínimo 4 caracteres';
    } else {
      return null;
    }
  }
}
