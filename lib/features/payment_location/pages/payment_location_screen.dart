import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gb_pay_mobile/constants/routes.dart';
import 'package:gb_pay_mobile/features/payment_location/pages/payment_location_screen.text.dart';
import 'package:gb_pay_mobile/models/cep_result_model.dart';
import 'package:gb_pay_mobile/models/paymentCard/paymentCard_model.dart';
import 'package:gb_pay_mobile/util/colors.dart';
import 'package:gb_pay_mobile/util/screen.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:search_cep/search_cep.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../components/payment_location_components/form_inptus_add_info.dart';
import '../../../components/payment_location_components/form_inputs_cep.dart';
import '../../../components/payment_location_components/form_inputs_city.dart';
import '../../../components/payment_location_components/form_inputs_data_uf.dart';
import '../../../services/cep_generator.dart';
import '../../../shared/payment_location/payment_location_preferences.dart';
import '../../../use_cases/cep_generator.dart';

class PaymentLocationScreen extends StatefulWidget with Screen {
  PaymentLocationScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<PaymentLocationScreen> createState() => _PaymentLocationScreenState();
}

class _PaymentLocationScreenState extends State<PaymentLocationScreen> {
  TextEditingController cepController = TextEditingController();
  TextEditingController bairroController = TextEditingController();
  TextEditingController enderecoController = TextEditingController();
  TextEditingController numeroController = TextEditingController();
  TextEditingController complementoController = TextEditingController();
  TextEditingController cidadeController = TextEditingController();
  TextEditingController estadoController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  ResultCep resultadoCep = ResultCep();
  String valorCep = '';

  late String dropdownValue;

  var maskFormatterCEP = MaskTextInputFormatter(
      mask: '#####-###', type: MaskAutoCompletionType.lazy);

  @override
  void initState() {
    super.initState();
    PaymentLocationScreenText.getStates();
    dropdownValue = dropdownValue = PaymentLocationScreenText.listOfStates[0];
  }

  @override
  Widget build(BuildContext context) {
    Future<void> pesquisaCep(String cep) async {
      final infoCep = await ViaCepService.fetchCep(cep: cep);
      if (infoCep.bairro == null) {
        bairroController.text = '';
        cidadeController.text = '';
        enderecoController.text = '';
      } else {
        bairroController.text = infoCep.bairro.toString();
        cidadeController.text = infoCep.localidade.toString();
        enderecoController.text = infoCep.logradouro.toString();
      }
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text(
          PaymentLocationScreenText.title,
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        toolbarHeight: 100,
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme:
            const IconThemeData(color: ColorsProject.blueWhite, size: 40.0),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
          child: SingleChildScrollView(
            child: ValueListenableBuilder(
              valueListenable: cepController,
              builder: (context, TextEditingValue value, __) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          PaymentLocationScreenText.estado,
                          style: TextStyle(
                            fontSize: 25.0,
                          ),
                        ),
                        InputDecorator(
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(5.0),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: ColorsProject.strongGrey,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: ColorsProject.strongGrey,
                              ),
                            ),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: dropdownValue,
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropdownValue = newValue!;
                                });
                              },
                              items: PaymentLocationScreenText.listOfStates
                                  .map<DropdownMenuItem<String>>(
                                      (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 12.0,
                        ),
                      ],
                    ),
                    FormInputsCEP(
                        Controller: cepController,
                        title: PaymentLocationScreenText.cep,
                        mask: maskFormatterCEP,
                        func: pesquisaCep),
                    FormInputsUF(
                      numeroCartaoController: bairroController,
                      title: PaymentLocationScreenText.bairro,
                    ),
                    FormInputsUF(
                      numeroCartaoController: enderecoController,
                      title: PaymentLocationScreenText.endereco,
                    ),
                    FormInputsUF(
                      numeroCartaoController: numeroController,
                      title: PaymentLocationScreenText.numero,
                    ),
                    FormInputsAdd(
                      numeroCartaoController: complementoController,
                      title: PaymentLocationScreenText.complemento,
                    ),
                    FormInputsCity(
                      numeroCartaoController: cidadeController,
                      title: PaymentLocationScreenText.cidade,
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 60.0,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            PaymentLocationPreferencs.setBairro(
                                bairroController.text);
                            PaymentLocationPreferencs.setCep(
                                cepController.text);
                            PaymentLocationPreferencs.setCidade(
                                cidadeController.text);
                            PaymentLocationPreferencs.setComplemento(
                                complementoController.text);
                            PaymentLocationPreferencs.setEndereco(
                                enderecoController.text);
                            PaymentLocationPreferencs.setNumero(
                                numeroController.text);
                            PaymentLocationPreferencs.setUf(dropdownValue);
                            widget.navigator
                                .pushNamed(AppRouteNames.paymentSummary);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                          primary: ColorsProject.blueWhite,
                          elevation: 0,
                        ),
                        child: const Text(
                          PaymentLocationScreenText.continueButton,
                          style: TextStyle(fontSize: 28.0),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
