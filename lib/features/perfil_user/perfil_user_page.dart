import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../util/assets.dart';
import '../../util/colors.dart';

class PerfilUserPage extends StatefulWidget {
  const PerfilUserPage({Key? key}) : super(key: key);

  @override
  State<PerfilUserPage> createState() => _PerfilUserPageState();
}

class _PerfilUserPageState extends State<PerfilUserPage> {
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          child: Column(
            children: [
              Image.asset('assets/images/construcao_app.png'),
              Padding(
                padding: const EdgeInsets.only( top: 128.0,bottom: 4.0),
                child: Center(
                    child: Text(
                  'Estamos Desenvolvendo esta página.',
                  style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.black),
                )),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 128.0,),
                child: Center(
                    child: Text(
                  'Aguarde!',
                  style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.black),
                )),
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                          primary: Colors.red,
                          elevation: 0,
                        ),
                  child: const Text(
                    'Voltar',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'Poppins',
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
