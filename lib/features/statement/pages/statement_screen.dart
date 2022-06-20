import 'package:flutter/material.dart';

import '../../../constants/routes.dart';
import '../../../util/assets.dart';
import '../../../util/colors.dart';

class StatementPage extends StatefulWidget {
  const StatementPage({Key? key}) : super(key: key);

  @override
  State<StatementPage> createState() => _StatementPageState();
}

class _StatementPageState extends State<StatementPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: Image.asset(
          AppAssets.logoIcon,
          color: Colors.white,
          fit: BoxFit.fill,
        ),
        leadingWidth: MediaQuery.of(context).size.width,
        iconTheme: const IconThemeData(color: Colors.white, size: 40.0),
      ),
      body: Column(
        children: [
          _backButton,
          _mountInfoPage,
        ],
      ),
    );
  }

  Widget get _mountInfoPage {
    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        width: 330.0,
        child: Column(
          children: [
            infoPageD('PAGAMENTO de Título Banco', 'R\$ 1.500,00'),
            _divider,
            infoPageC('DEPÓSITO TED', 'R\$ 10.500,00'),
            _divider,
            infoPageD('PAGAMENTO de Título Banco', 'R\$ 3.500,00'),
            _divider,
            infoPageD('PAGAMENTO de Título Banco', 'R\$ 2.500,00'),
            _divider,
            infoPageD('Transferência', 'R\$ 500,00'),
            _divider,
            infoPageC('DEPÓSITO PIX', 'R\$ 20,00'),
            _divider,
            infoPageC('SALDO', 'R\$ 9.800,00'),
          ],
        ),
      ),
    );
  }

  Widget get _backButton {
    return const Align(
        alignment: Alignment.topLeft,
        child: BackButton(
          color: ColorsProject.blueWhite,
        ));
  }

  Widget infoPageD(String info, String infoSupply) {
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
                fontSize: 16.0,
                color: ColorsProject.whiteSilver,
                fontWeight: FontWeight.normal,
              ),
            ),
            Text(
              infoSupply,
              style: const TextStyle(
                fontSize: 12.0,
                color: Colors.red,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget infoPageC(String info, String infoSupply) {
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
                fontSize: 16.0,
                color: ColorsProject.whiteSilver,
                fontWeight: FontWeight.normal,
              ),
            ),
            Text(
              infoSupply,
              style: const TextStyle(
                fontSize: 12.0,
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
      padding: const EdgeInsets.only(top: 8.0),
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
        top: 16.0,
      ),
      child: SizedBox(
        width: 330.0,
        height: 60.0,
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, AppRouteNames.creditcard);
          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.0),
            ),
            primary: ColorsProject.blueWhite,
            elevation: 0,
          ),
          child: const Text(
            'Próximo',
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
