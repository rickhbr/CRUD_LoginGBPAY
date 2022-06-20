import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '../../util/colors.dart';

class FormInputsUF extends StatelessWidget {
  final TextEditingController numeroCartaoController;
  final String title;

  FormInputsUF({
    Key? key,
    required this.numeroCartaoController,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 25.0,
          ),
        ),
        TextFormField(
          controller: numeroCartaoController,
          validator: MultiValidator([RequiredValidator(errorText: 'Por favor insira um $title')]),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: const InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: ColorsProject.strongGrey,
              ),
            ),
            // Border quando usuario clica no input
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(
          height: 12.0,
        ),
      ],
    );
  }
}