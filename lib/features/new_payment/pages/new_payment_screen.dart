import 'package:flutter/material.dart';
import 'package:gb_pay_mobile/constants/routes.dart';
import 'package:gb_pay_mobile/models/ticket_query/ticket_query.dart';
import 'package:gb_pay_mobile/util/colors.dart';
import 'package:intl/intl.dart';

import '../../../shared/new_payment/new_payment_preferences.dart';
import '../../../util/assets.dart';

class NewPaymentPage extends StatefulWidget {
  final TicketQuery ticketInfo;

  const NewPaymentPage({Key? key, required this.ticketInfo}) : super(key: key);

  @override
  State<NewPaymentPage> createState() => _NewPaymentPageState();
}

class _NewPaymentPageState extends State<NewPaymentPage> {
  bool _checkToday = false;
  bool _checkOther = false;
  late String code = '';
  String dateCalendar = '';
  TextEditingController dateController = TextEditingController();
  DateTime data = DateTime.now();

  @override
  void initState() {
    super.initState();
    dateController.addListener(() {
      dateCalendar = DateTime.now().toString();
      //code = arguments['/codeBarPage'];
    });
  }

  @override
  void dispose() {
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          'Novo Pagamento',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        toolbarHeight: 100,
        iconTheme:
            const IconThemeData(color: ColorsProject.blueWhite, size: 40.0),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              _payAccount,
              _divider,
              _mountInfoPage,
            ],
          ),
          _continueButton
        ],
      ),
    );
  }

  Widget get _payAccount {
    return Padding(
      padding: const EdgeInsets.only(
        // top: 144.0,
        left: 40.0,
      ),
      child: Row(
        children: [
          Column(
            children: [
              Container(
                width: 56.0,
                height: 56.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: ColorsProject.blueWhite,
                ),
                child: Image.asset(
                  AppAssets.barCodeSmallIcon,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Pagar conta',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25.0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 8.0,
                  ),
                  child: Text(
                    'R\$ ${widget.ticketInfo.value.toString().replaceAll('.', ',')}',
                    style: const TextStyle(
                      color: ColorsProject.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 25.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }


  Widget get _mountInfoPage {
    return Column(
      children: [
        infoPage('Data de pagamento', DateFormat("dd/MM/yyyy").format(data)),
        infoPage('Beneficiário', widget.ticketInfo.assignor),
        infoPage('Vencimento', widget.ticketInfo.dueDate ?? 'Sem Vencimento'),
        infoPage('Forma de pagamento', 'Cartão de crédito'),
      ],
    );
  }

  Widget infoPage(String info, dynamic infoSupply) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 25.0,
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              info,
              style: const TextStyle(
                fontSize: 18.0,
                color: ColorsProject.whiteSilver,
                fontWeight: FontWeight.normal,
              ),
            ),
            Text(
              '$infoSupply',
              style: const TextStyle(
                fontSize: 18.0,
                color: ColorsProject.whiteSilver,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget get _divider {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: 1.0,
        color: ColorsProject.whiteSilver,
      ),
    );
  }

  Widget get _continueButton {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 25.0,
      ),
      child: SizedBox(
        width: 330.0,
        height: 60.0,
        child: ElevatedButton(
          onPressed: () {
            print(widget.ticketInfo.value);
            NewPaymentPreferencs.setAssignor(widget.ticketInfo.assignor);
            NewPaymentPreferencs.setTransactionId(widget.ticketInfo.transactionId);
            Navigator.pushNamed(context, AppRouteNames.creditcard, arguments: widget.ticketInfo.value);
          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.0),
            ),
            primary: ColorsProject.blueWhite,
            elevation: 0,
          ),
          child: const Text(
            'Confirmar',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28.0,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
