import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../util/colors.dart';

class FormInputsSignupEmail extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  final String hintText;
  final int length;
  final List<TextInputFormatter> mask;
  final bool obscure;

  const FormInputsSignupEmail({
    Key? key,
    required this.controller,
    required this.title,
    this.hintText = '',
    this.obscure = false,
    this.mask = const [],
    this.length = 20,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            title,
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
          maxLength: length,
          inputFormatters: mask,
          controller: controller,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: MultiValidator([
            RequiredValidator(errorText: 'Por favor, insira um $title'),
            EmailValidator(errorText: 'Insira um e-mail válido')
          ]),
          decoration: InputDecoration(
            counterText: '',
            hintText: hintText,
            border: const OutlineInputBorder(),
            contentPadding: const EdgeInsets.fromLTRB(14, 2, 2, 0),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 2, color: Colors.grey),
              borderRadius: BorderRadius.circular(6),
            ),
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
      ],
    );
  }
}
