import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '../../util/colors.dart';

class FormInputsPassword extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  final String hintText;
   bool obscure;

   FormInputsPassword({
    Key? key,
    required this.controller,
    required this.title,
    this.hintText = '',
    this.obscure = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool hiddenPass = false;
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
          validator: validatorPass,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            hintText: hintText,
            suffixIcon: IconButton(
              onPressed: (){
              },
              icon: Icon(Icons.visibility),
            ),
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
  void togglePasswordView(){
    if(obscure == true){
      obscure = false;
    }else{
       obscure = true;
    }
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
