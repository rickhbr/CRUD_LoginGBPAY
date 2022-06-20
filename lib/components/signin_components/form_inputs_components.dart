import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '../../util/colors.dart';

class FormInputs extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  final String hintText;
  final bool obscure;

  const FormInputs({
    Key? key,
    required this.controller,
    required this.title,
    this.hintText = '',
    this.obscure = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
            alignment: Alignment.topLeft,
            child: Text(
              title,
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.black,
              ),
            )),
        const SizedBox(
          height: 10.0,
        ),
        TextFormField(
          controller: controller,
          validator: MultiValidator([
                      EmailValidator(
                          errorText: 'Por favor, insira um $title válido'),
                      RequiredValidator(
                          errorText: 'Por favor, insira um $title'),
                    ]),
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            hintText: hintText,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 20, horizontal: 4),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 2, color: Colors.grey),
              borderRadius: BorderRadius.circular(6),
            ),
          ),
           obscureText: obscure,
        ),
      ],
    );
  }
}
