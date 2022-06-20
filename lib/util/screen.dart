import 'package:flutter/material.dart';
import 'package:gb_pay_mobile/util/global_context.dart';

final ValueNotifier<bool> _called = ValueNotifier(false);

mixin Screen on Widget {
  final GlobalContext _context = GlobalContext.I;

  NavigatorState get navigator =>
      Navigator.of(_context.context!, rootNavigator: true);

  MediaQueryData get media => MediaQuery.of(_context.context!);

  void initState() {
    _called.value = true;
  }
}
