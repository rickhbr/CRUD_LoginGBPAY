import 'package:flutter/material.dart';

class GlobalContext {
  GlobalContext._();

  static final GlobalContext I = GlobalContext._();

  final ValueNotifier<BuildContext?> ctx = ValueNotifier<BuildContext?>(null);

  BuildContext? get context {
    if (ctx.value == null) throw Exception('Context has not been set');
    return ctx.value;
  }

  void setContext(BuildContext context) {
    ctx.value = context;
  }
}
