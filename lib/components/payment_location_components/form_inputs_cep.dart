import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../util/colors.dart';

class FormInputsCEP extends StatelessWidget {
  final TextEditingController Controller;
  final String title;
  final TextInputFormatter mask;
  final Function(String) func;
  late String valorCep;

  FormInputsCEP({
    Key? key,
    required this.Controller,
    required this.title,
    required this.mask,
    this.valorCep = '',
    required this.func,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'CEP',
          style: const TextStyle(
            fontSize: 25.0,
          ),
        ),
        TextFormField(
          controller: Controller,
          maxLength: 9,
          validator: cepValidator,
          inputFormatters: [mask],
          autovalidateMode: AutovalidateMode.onUserInteraction,
          onEditingComplete: () {
            if (Controller.text == '' || Controller.text.length < 9) {
              return null;
            }
            valorCep = Controller.text.replaceAll('-', '');
            func(valorCep);
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          decoration: const InputDecoration(
            counterText: '',
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

  String? cepValidator(value) {
    if (value == '' || value.length < 9) {
      return 'Preencher com cep válido';
    }
    return null;
  }
}