import 'package:boleto/boleto.dart';
import 'package:flutter/material.dart';

import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:gb_pay_mobile/features/code_bar/pages/code_bar.text.dart';
import 'package:gb_pay_mobile/services/ticket_query_dto.dart';
import 'package:gb_pay_mobile/util/assets.dart';
import 'package:gb_pay_mobile/util/colors.dart';
import 'package:gb_pay_mobile/util/screen.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../../constants/routes.dart';
import '../../../shared/code_bar/code_bar_preferences.dart';
import '../../../widgets/loader.dart';

class CodeBarPage extends StatefulWidget with Screen {
  CodeBarPage({Key? key}) : super(key: key);

  @override
  State<CodeBarPage> createState() => _CodeBarPageState();
}

class _CodeBarPageState extends State<CodeBarPage> {
  final _formKey = GlobalKey<FormState>();
  final TicketQueryDTO _ticketQueryDTO = TicketQueryDTO();
  String data = "";

  String codeBar = '';
  String description = '';
  TextEditingController codeBarController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  var maskFormatter = MaskTextInputFormatter(
      mask: '#####.##### #####.###### ### #####.###### # ##############',
      type: MaskAutoCompletionType.lazy);
  bool isLoading = false;

  Future scanCodeBar() async {
    String code = await FlutterBarcodeScanner.scanBarcode(
        '#000000', 'Cancelar', true, ScanMode.BARCODE);

    setState(() {
      data = code;
      print('data');
      print(data);
      // tipo do boleto, se o codigo de barras começar com 8 o tipo é 1, com 8 é conta de luz, agua
      // tipo 2 é tipo banco
      var codeBarType = 1;
      if (data.substring(0, 1) == "8") {
        codeBarType = 1;
      } else {
        codeBarType = 2;
      }
      //

      _ticketQueryDTO.ticketQuery(codeBarType, '', data).then((value) {
        CodeBarPreferencs.setCodeBar(data);
        CodeBarPreferencs.setCodeBarType(codeBarType.toInt());
        CodeBarPreferencs.setDigitable(data);
        print('value on scan');
        print(value);
        widget.navigator.pushNamed(
          AppRouteNames.newPaymentPage,
          arguments: value,
        );
      }).catchError((error) {
        print(error);
        print('Tente ler o codigo de barras mais de perto.');
      });
    });
  }

  @override
  void initState() {
    super.initState();
    codeBarController.addListener(() {
      codeBar = codeBarController.text;
      description = descriptionController.text;
    });
  }

  @override
  void dispose() {
    codeBarController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          CodeBarText.title,
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
        actions: [
          IconButton(
            onPressed: () {
              scanCodeBar();
            },
            icon: Image.asset(
              AppAssets.cameraIcon,
              color: ColorsProject.blueWhite,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 50.0,
        ),
        child: SizedBox(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _codeBar(context),
                _description(context),
                _continueButton,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _codeBar(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            bottom: 8.0,
          ),
          child: SizedBox(
            width: 330.0,
            child: Align(
              alignment: Alignment.topLeft,
              child: RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: CodeBarText.codeBar,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25.0,
                      ),
                    ),
                    TextSpan(text: '   '),
                    WidgetSpan(
                      child: Icon(
                        Icons.info,
                        size: 20.0,
                        color: ColorsProject.whiteSilverLow,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Center(
          child: SizedBox(
            width: 330.0,
            child: TextFormField(
              inputFormatters: [maskFormatter],
              controller: codeBarController,
              style: const TextStyle(
                fontSize: 18.0,
              ),
              maxLines: 2,
              decoration: const InputDecoration(
                border: InputBorder.none,
                isDense: true,
              ),
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
              onChanged: (text) {
                codeBar = codeBarController.text;
                codeBar = codeBar.replaceAll('.', '');
                codeBar = codeBar.replaceAll(' ', '');
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'O código deve ser preenchido';
                }
                return null;
              },
            ),
          ),
        ),
        _divider,
      ],
    );
  }

  Widget _description(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 40.0,
        bottom: 24.0,
      ),
      child: SizedBox(
        width: 330.0,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(
                bottom: 16.0,
              ),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  CodeBarText.description,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25.0,
                  ),
                ),
              ),
            ),
            Center(
              child: TextFormField(
                controller: descriptionController,
                style: const TextStyle(
                  fontSize: 16.0,
                ),
                maxLines: 2,
                decoration: const InputDecoration(
                  hintText: CodeBarText.exampleDescription,
                  border: InputBorder.none,
                  isDense: true,
                ),
                textInputAction: TextInputAction.done,
                onChanged: (text) {
                  description = descriptionController.text;
                },
              ),
            ),
            _divider,
          ],
        ),
      ),
    );
  }

  Widget get _continueButton {
    return SizedBox(
      width: 330.0,
      height: 60.0,
      child: ElevatedButton(
        onPressed: () async {
          if (_formKey.currentState!.validate() || isLoading) {
            setState(() {
              isLoading = true;
            });
            // tipo do boleto, se o codigo de barras começar com 8 o tipo é 1, com 8 é conta de luz, agua
            // tipo 2 é tipo banco
            var codeBarType = 1;
            if (codeBarController.text.substring(0, 1) == "8") {
              codeBarType = 1;
            } else {
              codeBarType = 2;
            }
            //
            var codeBarEdited = codeBarController.text.replaceAll('.', '');
            codeBarEdited = codeBarEdited.replaceAll(' ', '');

            _ticketQueryDTO
                .ticketQuery(codeBarType, codeBarEdited, '')
                .then((value) {
              CodeBarPreferencs.setCodeBar(codeBarEdited);
              CodeBarPreferencs.setCodeBarType(codeBarType.toInt());
              CodeBarPreferencs.setDigitable(codeBarEdited);
              CodeBarPreferencs.setCodeBarOriginal(codeBarController.text);
              widget.navigator.pushNamed(
                AppRouteNames.newPaymentPage,
                arguments: value,
              );
            }).catchError((error) {
              print(error);
            });
          }
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
            ? LoaderWidget()
            : const Text(
                CodeBarText.nextButton,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28.0,
                  fontWeight: FontWeight.normal,
                ),
              ),
      ),
    );
  }

  Widget get _divider {
    return Container(
      width: 330.0,
      height: 2.0,
      color: ColorsProject.blueWhite,
    );
  }
}
