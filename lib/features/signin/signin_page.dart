import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:gb_pay_mobile/components/signup_components/password_component.dart';
import 'package:gb_pay_mobile/constants/routes.dart';
import 'package:gb_pay_mobile/features/signin/signin_page.text.dart';
import 'package:gb_pay_mobile/services/signin_dto.dart';
import 'package:gb_pay_mobile/util/colors.dart';
import 'package:gb_pay_mobile/util/screen.dart';
import 'package:gb_pay_mobile/widgets/messageError_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../components/signin_components/form_inputs_components.dart';
import '../../components/signin_components/form_inputs_password.dart';
import '../../shared/user_data/signin_preferences.dart';
import '../../widgets/loader.dart';
import '../../widgets/new_account.dart';

class SigninPage extends StatefulWidget with Screen {
  SigninPage({Key? key}) : super(key: key);

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool obscure = true;

  SigninDTO _signinDTO = SigninDTO();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback(
      (_) {
        _signinDTO = SigninDTO();
        isLoading = false;
      },
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Center(
            child: SizedBox(
              width: 330.0,
              child: Column(
                children: [
                  const SizedBox(
                    height: 180.0,
                  ),
                  Image.asset('assets/images/gbiconcolor.png'),
                  const SizedBox(
                    height: 24.0,
                  ),
                  const Align(
                      alignment: Alignment.center,
                      child: Text(
                        SigninPageText.welcomeTitle,
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.black87,
                        ),
                      )),
                  const SizedBox(
                    height: 40.0,
                  ),
                  FormInputs(
                    controller: emailController,
                    title: SigninPageText.titleEmail,
                    hintText: SigninPageText.hintEmail,
                  ),
                  const SizedBox(
                    height: 32.0,
                  ),
                   Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Senha',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.black,
              ),
            )),
        const SizedBox(
          height: 10.0,
        ),
        TextFormField(
          controller: passwordController,
          validator: validatorPass,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            suffixIcon: IconButton(
              onPressed: (){
                setState(() {
                  obscure = !obscure;
                });
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
                  const SizedBox(
                    height: 40.0,
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
                          _signinDTO
                              .signin(
                                  emailController.text, passwordController.text)
                              .then((value) {
                            UserPreferencs.setToken(value.accessToken);
                            UserPreferencs.setUserName(value.name);
                            UserPreferencs.setUserId(value.id);
                            widget.navigator.pushNamed(
                              AppRouteNames.paymentpage,
                              arguments: UserPreferencs.getUserName(),
                            );
                          }).catchError((error) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                elevation: 0,
                                backgroundColor: Colors.transparent,
                                content: MessageError(
                                  text: SigninPageText.invalidUser,
                                ),
                                duration: Duration(seconds: 3),
                              ),
                            );
                          });
                        }
                        await Future.delayed(Duration(seconds: 1));
                        if (isLoading = mounted) {
                          setState(() {
                            isLoading = false;
                          });
                        }
                      },
                      child: isLoading
                          ? LoaderWidget()
                          : Text(
                              SigninPageText.continuePage,
                              style: TextStyle(
                                fontSize: 22.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  const NewAccount(),
                ],
              ),
            ),
          ),
        ),
      ),
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

  void togglePasswordView(){
    if(obscure == true){
      obscure = false;
    }else{
       obscure = true;
    }
  }
  

  _setToken(token, name, id) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString('token', token);
    prefs.setString('userName', name);
    prefs.setString('userId', id.toString());
  }
}
