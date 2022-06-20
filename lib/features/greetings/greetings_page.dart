import 'package:flutter/material.dart';
import 'package:gb_pay_mobile/constants/routes.dart';
import 'package:gb_pay_mobile/util/assets.dart';
import 'package:gb_pay_mobile/util/colors.dart';
import 'package:gb_pay_mobile/util/screen.dart';
import 'greetings_page.text.dart';

class GreetingsPage extends StatefulWidget with Screen {
  GreetingsPage({Key? key}) : super(key: key);

  @override
  State<GreetingsPage> createState() => _GreetingsPageState();
}

class _GreetingsPageState extends State<GreetingsPage> {
  bool disabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          color: ColorsProject.blueWhite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Image.asset(
                      AppAssets.logoIcon,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 340.0,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () {
                          widget.navigator.pushNamed(AppRouteNames.signup);
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                        ),
                        child: const Text(
                          GreetingsScreenText.start,
                          style: TextStyle(
                            fontSize: 16,
                            color: ColorsProject.surface,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: 340.0,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () {
                          widget.navigator.pushNamed(AppRouteNames.signin);
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                        ),
                        child: const Text(
                          GreetingsScreenText.enterAccount,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // SizedBox(
                    //   width: 340.0,
                    //   height: 48,
                    //   child: OutlinedButton(
                    //     style: OutlinedButton.styleFrom(
                    //       side: const BorderSide(
                    //         color: Colors.white,
                    //         width: 2,
                    //         style: BorderStyle.solid,
                    //       ),
                    //       shape: RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.circular(100),
                    //       ),
                    //     ),
                    //     onPressed: () {
                    //       widget.navigator.pushNamed(AppRouteNames.token);
                    //     },
                    //     child: const Text(
                    //       GreetingsScreenText.token,
                    //       style: TextStyle(
                    //         fontSize: 16,
                    //         color: Colors.white,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
