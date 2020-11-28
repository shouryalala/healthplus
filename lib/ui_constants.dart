import 'package:flutter/material.dart';

class UiConstants{
  UiConstants._();

//  static final Color primaryColor = Colors.greenAccent[400];
  //static final Color primaryColor = const Color.fromARGB(255, 58, 134, 255);
  //static final Color accentColor = Colors.grey[800];
  static final Color primaryColor = const Color(0xff03da9d);
  static final Color accentColor = const Color(0xff333333);
  static final Color darkPrimaryColor = const Color.fromARGB(255, 58, 120, 255);
  static final Color secondaryColor = const Color.fromARGB(255, 241, 227, 243);
  static final Color chipColor = const Color.fromARGB(255, 241, 227, 243);

  static final Color positiveAlertColor = Colors.blueAccent[400];
  static final Color negativeAlertColor = Colors.blueGrey;
//  static final Color secondaryColor = Colors.greenAccent;
  static final Color spinnerColor = Colors.grey[400];
  static final Color spinnerColor2 = Colors.grey[200];
  //dimens
  static final double dialogRadius = 20.0;
  static const double padding = 16.0;
  static const double avatarRadius = 96.0;

  static offerSnacks(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
    );
    Scaffold.of(context).showSnackBar(snackBar);
    return;
  }


  // static List<Color> boardColors = [Colors.green[100],Colors.green[200],Colors.green[300],Colors.green[400],
  //   Colors.green,Colors.green[600],Colors.green[700],Colors.green[800],Colors.green[900],Colors.lightGreen,
  //   Colors.lightGreen[600],Colors.lightGreen[700],Colors.lightGreen[800],Colors.lightGreen[900]];

  static List<Color> boardColors = [Colors.greenAccent];

}