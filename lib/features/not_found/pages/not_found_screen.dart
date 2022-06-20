import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gb_pay_mobile/features/not_found/pages/not_found_sceen.text.dart';
import 'package:gb_pay_mobile/util/screen.dart';

class NotFoundScreen extends StatelessWidget with Screen {
  NotFoundScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Center(
              child: Text(
                NotFoundScreenText.errorCode,
                style: TextStyle(
                  fontSize: 56,
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Center(
              child: CupertinoButton.filled(
                child: const Text(
                  NotFoundScreenText.backOption,
                ),
                onPressed: () => navigator.pop(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
