import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../constants/routes.dart';

class DrawerGBPay extends StatelessWidget {
  const DrawerGBPay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: const Color(0xFF00C0FF),
        child: Padding(
          padding: const EdgeInsets.only(
            top: 72.0,
          ),
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              ListTile(
                leading: const Icon(
                  Icons.person,
                  color: Colors.white,
                ),
                title: const Text(
                  'Perfil do usuário',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  Navigator.pushNamed(context, AppRouteNames.perfilUser);
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.money,
                  color: Colors.white,
                ),
                hoverColor: Colors.white70,
                title: const Text(
                  'Extrato',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17.0,
                    color: Colors.white,
                  ),
                ),
                onTap: () {
                  Navigator.pushNamed(context, AppRouteNames.statement);
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.exit_to_app,
                  color: Colors.white,
                ),
                hoverColor: Colors.white70,
                title: const Text(
                  'Sair',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17.0,
                    color: Colors.white,
                  ),
                ),
                onTap: () {
                  Navigator.pushNamed(context, AppRouteNames.greetings);
                },
              ),
            ],
          ),
        ),
      );
  }
}