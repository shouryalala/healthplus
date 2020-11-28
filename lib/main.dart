import 'dart:async';

import 'package:flutter/material.dart';
import 'package:healthplus/app_root.dart';
import 'package:healthplus/constants.dart';
import 'package:healthplus/home_page.dart';
import 'package:healthplus/launcher_screen.dart';
import 'package:healthplus/locator.dart';
import 'package:healthplus/ui_constants.dart';
import 'package:provider/provider.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // ChangeNotifierProvider(builder: (_) => locator<>()),
        // ChangeNotifierProvider(builder: (_) => locator<LocalDBModel>()),
        // ChangeNotifierProvider(builder: (_) => locator<BaseUtil>()),
        // ChangeNotifierProvider(builder: (_) => locator<FcmListener>()),
        // ChangeNotifierProvider(builder: (_) => locator<FcmHandler>()),
      ],
      child: MaterialApp(
        title: Constants.APP_NAME,
        theme: ThemeData(
          primaryColor: UiConstants.primaryColor,
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: SplashScreen(),
        routes: <String, WidgetBuilder>{
          '/launcher': (BuildContext context) => SplashScreen(),
          '/approot': (BuildContext context) => AppRoot(),
          '/neonatal': (BuildContext context) => HomePage(pageType: 0,),
          '/cbd': (BuildContext context) => HomePage(pageType: 1,),
          // '/gametab': (BuildContext context) =>
          //     MyHomePage(title: Constants.APP_NAME),
          // '/savetab': (BuildContext context) =>
          //     MyHomePage(title: Constants.APP_NAME),
          // '/refertab': (BuildContext context) =>
          //     MyHomePage(title: Constants.APP_NAME),
          // '/settings': (BuildContext context) => SettingsPage(),
          // '/faq': (BuildContext context) => FAQPage(),
          // '/deposit': (BuildContext context) => UpiPayment(),
        },
      ),
    );
  }
}
