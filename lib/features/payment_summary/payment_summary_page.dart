import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';

import '../../constants/routes.dart';
import '../../services/paymentCard_dto.dart';
import '../../shared/credit_card/credit_card_data_preferences.dart';
import '../../util/colors.dart';
import '../../widgets/loader.dart';

class PaymentSummaryPage extends StatefulWidget {
  const PaymentSummaryPage({Key? key}) : super(key: key);

  @override
  State<PaymentSummaryPage> createState() => _PaymentSummaryPageState();
}

DateTime data = DateTime.now();
CreditCardPreferencs creditCard = CreditCardPreferencs();
PaymentCardDTO _paymentCard = PaymentCardDTO();
final _formKey = GlobalKey<FormState>();
bool isLoading = false;

class _PaymentSummaryPageState extends State<PaymentSummaryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text(
          'Resumo de Pagamento',
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(28.0, 12.0, 28.0, 16.0),
          child: SizedBox(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  FormInputsSummaryTransaction(
                      title: 'Transação:', dataTitle: 1080025246),
                  FormInputsSummaryTransaction(
                      title: 'Data de Pagamento:',
                      dataTitle: DateFormat("dd/MM/yyyy").format(data)),
                  SizedBox(
                    height: 28.0,
                  ),
                  FormInputsSummaryCard(
                      title: 'Final do Cartão de Crédito:',
                      dataTitle: CreditCardPreferencs.getCardNumber()!
                          .substring(12, 16)),
                  FormInputsSummaryCard(
                      title: 'Pgto. Cartão:',
                      dataTitle:
                          'R\$ ${CreditCardPreferencs.getAmountDouble()?.replaceAll('.', ',')}'),
                  FormInputsSummaryCard(
                      title: 'Valor do boleto:',
                      dataTitle:
                          'R\$ ${CreditCardPreferencs.getAmountOrigin()?.replaceAll('.', ',')}'),
                  FormInputsSummaryCard(
                      title: 'Total pago:',
                      dataTitle:
                          'R\$ ${CreditCardPreferencs.getAmountDouble()?.replaceAll('.', ',')}'),
                  SizedBox(
                    height: 28.0,
                  ),
                  FormInputsSummaryDescription(
                      title: 'Descrição:', dataTitle: 'Descrição do Pgto'),
                  FormInputsSummaryDescription(
                      title: 'Vencimento:', dataTitle: 'Não informado'),
                  FormInputsSummaryDescription(
                      title: 'Beneficiário:', dataTitle: 'Não informado'),
                  FormInputsSummaryDescription(
                      title: 'Pagador:',
                      dataTitle: CreditCardPreferencs.getCardHolder()),
                  FormInputsSummaryDescription(
                      title: 'Documento do Pagador:',
                      dataTitle: CreditCardPreferencs
                          .getCardHolderDocumentUnformated()),
                  FormInputsSummaryDescription(
                      title: 'Valor do documento:',
                      dataTitle:
                          'R\$ ${CreditCardPreferencs.getAmountOrigin()?.replaceAll('.', ',')}'),
                  SizedBox(
                    height: 18.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 25.0,
                    ),
                    child: SizedBox(
                      width: 330.0,
                      height: 60.0,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate() || isLoading) {
                            setState(() {
                              isLoading = true;
                            });
                            var jsonCode = {};
                            if (CreditCardPreferencs.getInstallments()! != 1) {
                              jsonCode = {
                                'card': {
                                  'cardNumber': CreditCardPreferencs.getCardNumber(),
                                  'cardHolder': CreditCardPreferencs.getCardHolder(),
                                  'cardHolderDocument': CreditCardPreferencs.getCardHolderDocument(),
                                  'expirationMonth': CreditCardPreferencs.getExpirationMonth(),
                                  'expirationYear': CreditCardPreferencs.getExpirationYear(),
                                  'securityCode': CreditCardPreferencs.getSecurityCode(),
                                  'brand': CreditCardPreferencs.getBrand(),
                                },
                                'payment': {
                                  'documentNumber': CreditCardPreferencs.getCardHolderDocument(),
                                  'amount':
                                      CreditCardPreferencs.getAmount(),
                                  'installments': CreditCardPreferencs.getInstallments(),
                                },
                                'customer': {
                                  'firstName': CreditCardPreferencs.getCardHolder(),
                                  'lastName': CreditCardPreferencs.getCardHolder(),
                                  'documentNumber': '76600763000135',
                                }
                              };
                            } else if (CreditCardPreferencs.getInstallments()! == 1) {
                              jsonCode = {
                                'card': {
                                  'cardNumber': CreditCardPreferencs.getCardNumber(),
                                  'cardHolder': CreditCardPreferencs.getCardHolder(),
                                  'cardHolderDocument': CreditCardPreferencs.getCardHolderDocument(),
                                  'expirationMonth': CreditCardPreferencs.getExpirationMonth(),
                                  'expirationYear': CreditCardPreferencs.getExpirationYear(),
                                  'securityCode': CreditCardPreferencs.getSecurityCode(),
                                  'brand': CreditCardPreferencs.getBrand(),
                                },
                                'payment': {
                                  'documentNumber': CreditCardPreferencs.getCardHolderDocument(),
                                  'amount':
                                      CreditCardPreferencs.getAmount(),
                                },
                                'customer': {
                                  'firstName': CreditCardPreferencs.getCardHolder(),
                                  'lastName': CreditCardPreferencs.getCardHolder(),
                                  'documentNumber': '76600763000135',
                                }
                              };
                            }
                            //_paymentCard.payment(jsonCode).then((value) {});
                          }

                         Navigator.pushNamed(context, AppRouteNames.receipt);
                          await Future.delayed(Duration(seconds: 3));
                          if (isLoading = mounted) {
                            setState(() {
                              isLoading = false;
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                          primary: ColorsProject.blueWhite,
                          elevation: 0,
                        ),
                        child: isLoading
                            ? const LoaderWidget()
                            : const Text(
                                'Pagar',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 28.0,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class FormInputsSummaryTransaction extends StatelessWidget {
  final String title;
  final dynamic dataTitle;

  const FormInputsSummaryTransaction({
    Key? key,
    required this.title,
    required this.dataTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 18.0),
              ),
              Text(
                '$dataTitle',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
              ),
            ],
          ),
          SizedBox(
            height: 18.0,
          ),
        ],
      ),
    );
  }
}

class FormInputsSummaryCard extends StatelessWidget {
  final String title;
  final dynamic dataTitle;

  const FormInputsSummaryCard({
    Key? key,
    required this.title,
    required this.dataTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 18.0),
              ),
              Text(
                '$dataTitle',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
              ),
            ],
          ),
          SizedBox(
            height: 18.0,
          ),
        ],
      ),
    );
  }
}

class FormInputsSummaryDescription extends StatelessWidget {
  final String title;
  final dynamic dataTitle;

  const FormInputsSummaryDescription({
    Key? key,
    required this.title,
    required this.dataTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 18.0),
              ),
              Text(
                '$dataTitle',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
              ),
            ],
          ),
          SizedBox(
            height: 18.0,
          ),
        ],
      ),
    );
  }
}
