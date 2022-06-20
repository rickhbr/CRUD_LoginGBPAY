import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:gb_pay_mobile/components/credit_card_components/form_inputs_date_card_components.dart';
import 'package:gb_pay_mobile/components/credit_card_components/form_inputs_date_card_year_components.dart';
import 'package:gb_pay_mobile/constants/routes.dart';
import 'package:gb_pay_mobile/features/credit_card/pages/credit_card_screen.text.dart';
import 'package:gb_pay_mobile/models/paymentCard/paymentCard_model.dart';
import 'package:gb_pay_mobile/services/paymentCard_dto.dart';
import 'package:gb_pay_mobile/use_cases/fees.dart';
import 'package:gb_pay_mobile/util/colors.dart';
import 'package:gb_pay_mobile/util/screen.dart';
import 'package:gb_pay_mobile/widgets/loader.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gb_pay_mobile/shared/credit_card/credit_card_data_preferences.dart';

import '../../../components/credit_card_components/form_inputs_components.dart';

class CreditCardScreen extends StatefulWidget with Screen {
  final double valor;
  CreditCardScreen({Key? key, required this.valor}) : super(key: key);

  @override
  State<CreditCardScreen> createState() => _CreditCardScreenState();
}

class _CreditCardScreenState extends State<CreditCardScreen> {
  TextEditingController numeroParcelasController = TextEditingController();
  TextEditingController numeroCartaoController = TextEditingController();
  TextEditingController validadeMonthController = TextEditingController();
  TextEditingController validadeYearController = TextEditingController();
  TextEditingController cvvController = TextEditingController();
  TextEditingController nomeController = TextEditingController();
  TextEditingController cpfCnpjController = TextEditingController();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final _formKey = GlobalKey<FormState>();
  PaymentCardDTO _paymentCard = PaymentCardDTO();
  PaymentCardModel _payment = PaymentCardModel();
  List<double> fees = CreditCardScreenText.listOfFees;
  List<double> result = [];
  late List<String> listOfParcels = [];
  bool isLoading = false;
  String _dropdownValue = '';
  var maskFormatterCard = MaskTextInputFormatter(
      mask: '#### #### #### ####', type: MaskAutoCompletionType.lazy);
  var maskFormatterCPF = MaskTextInputFormatter(
      mask: '###.###.###-##', type: MaskAutoCompletionType.lazy);
  int month = 0;
  int year = 0;
  int installment = 0;
  List<double> valueAmount = [];

  @override
  void initState() {
    super.initState();
    _paymentCard = PaymentCardDTO();
    isLoading = false;
    List<double> fees = CreditCardScreenText.listOfFees;
    List<double> result = [];
    fessCalculate(result, widget.valor, fees, listOfParcels);
    _dropdownValue = listOfParcels[0];
    numeroParcelasController.text = _dropdownValue.substring(0, 1);
  }

  @override
  void dispose() {
    numeroCartaoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < fees.length; i++) {
      valueAmount.add(widget.valor + widget.valor * fees[i]);
    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          CreditCardScreenText.title,
          style: TextStyle(
            color: Colors.black,
            fontSize: 30,
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
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    CreditCardScreenText.parcelas,
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
                          value: _dropdownValue,
                          onChanged: (dynamic newValue) {
                            setState(() {
                              _dropdownValue = newValue;
                              if (int.parse(_dropdownValue.substring(0, 1)) <
                                  10) {
                                numeroParcelasController.text =
                                    _dropdownValue.substring(0, 1);
                              } else if (int.parse(
                                      _dropdownValue.substring(0, 2)) >=
                                  10) {
                                numeroParcelasController.text =
                                    _dropdownValue.substring(0, 2);
                              }
                              print(numeroParcelasController.text);
                            });
                          },
                          items: listOfParcels
                              .map<DropdownMenuItem<String>>((dynamic value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      )),
                ],
              ),
              FormInputs(
                numeroCartaoController: numeroCartaoController,
                title: CreditCardScreenText.cartao,
                icon: Icons.credit_card,
                validator: 'número de cartão',
                length: 20,
                mask: [maskFormatterCard],
                type: TextInputType.number,
              ),
              Row(
                children: [
                  Expanded(
                    child: FormInputsDateMonth(
                      numeroCartaoController: validadeMonthController,
                      title: 'Mês',
                      icon: Icons.calendar_month_outlined,
                      validator: 'o mês',
                      type: TextInputType.number,
                      length: 2,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: FormInputsDateYear(
                        numeroCartaoController: validadeYearController,
                        title: 'Ano',
                        icon: Icons.calendar_month_outlined,
                        validator: 'o ano',
                        type: TextInputType.number,
                        length: 2,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: FormInputs(
                        numeroCartaoController: cvvController,
                        title: CreditCardScreenText.cvv,
                        icon: Icons.lock_open_outlined,
                        validator: 'o cvv',
                        type: TextInputType.number,
                        length: 3,
                      ),
                    ),
                  ),
                ],
              ),
              FormInputs(
                numeroCartaoController: nomeController,
                title: CreditCardScreenText.nomeImpresso,
                icon: Icons.person_outline,
                validator: 'o nome',
                type: TextInputType.name,
              ),
              FormInputs(
                numeroCartaoController: cpfCnpjController,
                title: CreditCardScreenText.cpfCnpj,
                icon: Icons.badge_outlined,
                validator: 'o cpf',
                type: TextInputType.number,
                mask: [maskFormatterCPF],
                length: 15,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 60.0,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: ColorsProject.blueWhite,
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate() || isLoading) {
                      var brandType = '';
                      if (numeroCartaoController.text.substring(0, 1) == "4") {
                        brandType = 'visa';
                      } else if (numeroCartaoController.text.substring(0, 1) ==
                          "5") {
                        brandType = 'mastercard';
                      }
                      month = int.parse(validadeMonthController.text);
                      year = int.parse(validadeYearController.text);
                      installment = int.parse(numeroParcelasController.text);
                      print(installment);

                      var parcel = valueAmount[installment-1];
                      parcel = parcel/installment-1;

                      var newCardEdit = numeroCartaoController.text;
                      newCardEdit = newCardEdit.replaceAll(' ', '');

                      var cpf = cpfCnpjController.text;
                      cpf = cpf.replaceAll('.', '');
                      cpf = cpf.replaceAll('-', '');

                      setState(() {
                        isLoading = true;
                      });
                      var jsonCode = {};
                      if (installment > 1) {
                        CreditCardPreferencs.setInstallments(installment);
                        jsonCode = {
                          'card': {
                            'cardNumber': newCardEdit,
                            'cardHolder': nomeController.text,
                            'cardHolderDocument': cpf,
                            'expirationMonth': month,
                            'expirationYear': year,
                            'securityCode': cvvController.text,
                            'brand': brandType,
                          },
                          'payment': {
                            'documentNumber': cpf,
                            'amount': valueAmount[installment - 1].toInt(),
                            'installments': installment,
                          },
                          'customer': {
                            'firstName': nomeController.text,
                            'lastName': nomeController.text,
                            'documentNumber': '76600763000135',
                          }
                        };
                      } else if (installment == 1) {
                        jsonCode = {
                          'card': {
                            'cardNumber': newCardEdit,
                            'cardHolder': nomeController.text,
                            'cardHolderDocument': cpf,
                            'expirationMonth': month,
                            'expirationYear': year,
                            'securityCode': cvvController.text,
                            'brand': brandType,
                          },
                          'payment': {
                            'documentNumber': cpf,
                            'amount': valueAmount[installment - 1].toInt(),
                          },
                          'customer': {
                            'firstName': nomeController.text,
                            'lastName': nomeController.text,
                            'documentNumber': '76600763000135',
                          }
                        };
                      }
                      CreditCardPreferencs.setCardNumber(newCardEdit);
                      CreditCardPreferencs.setCardHolder(nomeController.text);
                      CreditCardPreferencs.setCardHolderDocument(cpf);
                      CreditCardPreferencs.setExpirationMonth(month);
                      CreditCardPreferencs.setExpirationYear(year);
                      CreditCardPreferencs.setSecurityCode(cvvController.text);
                      CreditCardPreferencs.setBrand(brandType);
                      CreditCardPreferencs.setAmount(
                          valueAmount[installment - 1].toInt());
                          CreditCardPreferencs.setParcel(parcel);
                          CreditCardPreferencs.setAmountDouble(valueAmount[installment - 1].toStringAsFixed(2));
                          CreditCardPreferencs.setAmountOrigin(widget.valor.toStringAsFixed(2));
                      CreditCardPreferencs.setDocumentNumber('76600763000135');
                      CreditCardPreferencs.setCardHolderDocumentUnformated(cpfCnpjController.text);
                      CreditCardPreferencs.setInstallments(installment.toInt());
                      widget.navigator.pushNamed(AppRouteNames.paymentLocation);

                      // _paymentCard.payment(jsonCode).then((value) {
                      // });
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
                      : const Text(
                          'Continuar',
                          style: TextStyle(fontSize: 28.0),
                        ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _setInstallment(installment) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setInt('installments', installment);
  }
}
