import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:gb_pay_mobile/features/signup/signup_page.text.dart';
import 'package:gb_pay_mobile/services/signup_dto.dart';
import 'package:gb_pay_mobile/util/colors.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gb_pay_mobile/util/screen.dart';

import '../../components/signup_components/inputs_components.dart';
import '../../components/signup_components/inputs_email_components.dart';
import '../../components/signup_components/password_component.dart';
import '../../constants/routes.dart';
import '../../widgets/divider.dart';
import '../../widgets/loader.dart';
import '../../widgets/messageError_widget.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController documentUserController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final _formKey = GlobalKey<FormState>();
  var maskFormatterCPF = MaskTextInputFormatter(
      mask: '###.###.###-##', type: MaskAutoCompletionType.lazy);

  SignupDTO _signupDTO = SignupDTO();
  String confirmPass = '';
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _signupDTO = SignupDTO();
    isLoading = false;
    passController.addListener(() {
      confirmPass = passController.text;
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    passController.dispose();
    emailController.dispose();
    addressController.dispose();
    documentUserController.dispose();
    confirmPassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: SizedBox(
              width: 330.0,
              child: Column(
                children: [
                  Image.asset('assets/images/gbiconcolor.png'),
                  const Padding(
                    padding: EdgeInsets.only(
                      top: 8.0,
                      bottom: 16.0,
                    ),
                    child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          SignupPageText.welcomeSignup,
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.black87,
                          ),
                        )),
                  ),
                  FormInputsSignup(
                    controller: nameController,
                    title: SignupPageText.titleName,
                  ),
                  FormInputsSignupEmail(
                    controller: emailController,
                    title: SignupPageText.titleEmail,
                    hintText: SignupPageText.hintEmail,
                  ),
                  FormInputsSignup(
                      controller: addressController,
                      title: SignupPageText.titleAddress),
                  FormInputsSignup(
                    controller: documentUserController,
                    title: SignupPageText.titleDocument,
                    hintText: SignupPageText.hintDocument,
                    mask: [maskFormatterCPF],
                    length: 14,
                  ),
                  FormInputsPass(
                    controller: passController,
                  ),
                  _confirmPass(),
                  const SizedBox(
                    height: 16.0,
                  ),
                  SizedBox(
                    width: 330.0,
                    height: 40.0,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: ColorsProject.blueWhite,
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate() || isLoading) {
                          setState(() {
                            isLoading = true;
                          });
                          var documentEdited = '';
                          documentEdited =
                              documentUserController.text.replaceAll('.', '');
                          documentEdited =
                              documentUserController.text.replaceAll('-', '');
                          documentEdited = documentEdited.replaceAll('.', '');
                          documentEdited = documentEdited.replaceAll('-', '');
                          _signupDTO
                              .signup(
                                  nameController.text,
                                  documentEdited,
                                  passController.text,
                                  emailController.text,
                                  addressController.text)
                              .then((value) {
                            _setUser(nameController.text, emailController.text,
                                documentEdited);
                          }).catchError((error) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                elevation: 0,
                                backgroundColor: Colors.transparent,
                                content: MessageError(
                                    text: SignupPageText.messageErroText),
                                duration: Duration(seconds: 3),
                              ),
                            );
                          });
                        }
                        await Future.delayed(Duration(seconds: 3));
                        if (isLoading = mounted) {
                          setState(() {
                            isLoading = false;
                          });
                        }
                      },
                      child: isLoading
                          ? LoaderWidget()
                          : Text(
                              SignupPageText.continueButton,
                              style: TextStyle(
                                fontSize: 22.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                  DividerWidget(
                    altura: 1,
                  ),
                  _backPage,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget get _backPage {
    return TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Text(
          SignupPageText.backButton,
          style: TextStyle(
            fontSize: 16.0,
          ),
        ));
  }

  Widget _confirmPass() {
    return Column(
      children: [
        const Align(
          alignment: Alignment.topLeft,
          child: Text(
            SignupPageText.titleConfirmPassword,
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.black,
            ),
          ),
        ),
        const SizedBox(
          height: 12.0,
        ),
        TextFormField(
          controller: confirmPassController,
          validator: (value) {
            if (value != confirmPass) {
              return SignupPageText.errorPassword;
            }
            return null;
          },
          obscureText: true,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            contentPadding: const EdgeInsets.fromLTRB(2, 2, 2, 0),
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

  _setUser(name, email, cpf) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString('userName', name);
    prefs.setString('email', email);
    prefs.setString('cpf', cpf);

    if (mounted) {
      CoolAlert.show(
          context: context,
          title: 'Sucesso!',
          type: CoolAlertType.success,
          text: 'Cadastro realizado com Sucesso!',
          confirmBtnText: 'Continuar',
          confirmBtnTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
          backgroundColor: Colors.white,
          confirmBtnColor: ColorsProject.blueWhite,
          onConfirmBtnTap: () {
            Navigator.pushNamed(context, AppRouteNames.signin, arguments: name);
          });
    }
  }
}
