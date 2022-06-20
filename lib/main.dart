import 'package:flutter/material.dart';
import 'package:gb_pay_mobile/constants/routes.dart';
import 'package:gb_pay_mobile/features/not_found/pages/not_found_screen.dart';
import 'package:gb_pay_mobile/shared/code_bar/code_bar_preferences.dart';
import 'package:gb_pay_mobile/shared/credit_card/credit_card_data_preferences.dart';
import 'package:gb_pay_mobile/shared/new_payment/new_payment_preferences.dart';
import 'package:gb_pay_mobile/shared/payment_location/payment_location_preferences.dart';
import 'package:gb_pay_mobile/util/global_context.dart';
import 'package:gb_pay_mobile/util/service_location.dart';
import 'package:gb_pay_mobile/shared/user_data/signin_preferences.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  NavigationService().setupLocator();
  await CreditCardPreferencs.init();
  await UserPreferencs.init();
  await PaymentLocationPreferencs.init();
  await CodeBarPreferencs.init();
  await NewPaymentPreferencs.init();
  runApp(const GbPayApp());
}

class GbPayApp extends StatefulWidget {
  const GbPayApp({Key? key}) : super(key: key);

  @override
  State<GbPayApp> createState() => _GbPayAppState();
}

class _GbPayAppState extends State<GbPayApp> {
  final ThemeData themeData = ThemeData.light();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: [const Locale('pt', 'BR')],
      debugShowCheckedModeBanner: false,
      initialRoute: AppRouteNames.greetings,
      navigatorKey: locator<NavigationService>().navigatorKey,
      theme: themeData.copyWith(
        textTheme: TextTheme(
          headline1: themeData.textTheme.headline1
              ?.copyWith(fontFamily: 'ArialRounded'),
          headline2: themeData.textTheme.headline2
              ?.copyWith(fontFamily: 'ArialRounded'),
          headline3: themeData.textTheme.headline3
              ?.copyWith(fontFamily: 'ArialRounded'),
          headline4: themeData.textTheme.headline4
              ?.copyWith(fontFamily: 'ArialRounded'),
          headline5: themeData.textTheme.headline5
              ?.copyWith(fontFamily: 'ArialRounded'),
          headline6: themeData.textTheme.headline6
              ?.copyWith(fontFamily: 'ArialRounded'),
          subtitle1: themeData.textTheme.subtitle1
              ?.copyWith(fontFamily: 'ArialRounded'),
          subtitle2: themeData.textTheme.subtitle2
              ?.copyWith(fontFamily: 'ArialRounded'),
          bodyText1: themeData.textTheme.bodyText1
              ?.copyWith(fontFamily: 'ArialRounded'),
          bodyText2: themeData.textTheme.bodyText2
              ?.copyWith(fontFamily: 'ArialRounded'),
          caption:
              themeData.textTheme.caption?.copyWith(fontFamily: 'ArialRounded'),
          button:
              themeData.textTheme.button?.copyWith(fontFamily: 'ArialRounded'),
          overline: themeData.textTheme.overline
              ?.copyWith(fontFamily: 'ArialRounded'),
        ),
      ),
      onGenerateRoute: (settings) => MaterialPageRoute(
        settings: settings,
        maintainState: false,
        builder: (context) {
          GlobalContext.I.setContext(context);
          return AppRoutes.routes[settings.name]?.call(settings.arguments) ??
              NotFoundScreen();
        },
      ),
    );
  }
}
