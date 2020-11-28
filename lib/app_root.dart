import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:healthplus/constants.dart';
import 'package:healthplus/ui_constants.dart';

class AppRoot extends StatefulWidget{

  @override
  State createState() => _AppRootState();
}

class _AppRootState extends State<AppRoot> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1.0,
        backgroundColor: UiConstants.primaryColor,
        iconTheme: IconThemeData(
          color: UiConstants.accentColor, //change your color here
        ),
        title: Text('${Constants.APP_NAME}',
            style: TextStyle(
                color: UiConstants.accentColor,
                fontWeight: FontWeight.w700,
                fontSize: 30.0)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: _buildHealthSectionWidget()
              ),
            ),
            Expanded(
              child: Padding(
                  padding: EdgeInsets.all(10),
                  child: _buildHealth2SectionWidget()
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHealthSectionWidget() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: Colors.red,
        boxShadow: [
          new BoxShadow(
              color: Colors.black12,
              offset: Offset.fromDirection(20, 7),
              blurRadius: 3.0,
              spreadRadius: 0.1
          )
        ],
        borderRadius: BorderRadius.all(Radius.circular(20)),
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          stops: [0.1, 0.4],
          colors: [Colors.red, Colors.white],
        ),
      ),
      child: InkWell(
        child: Text('NeoNatal section'),
        onTap: () {
          HapticFeedback.vibrate();
          Navigator.of(context).pushReplacementNamed('/neonatal');
        },
      ),
    );
  }

  Widget _buildHealth2SectionWidget() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: Colors.red,
        boxShadow: [
          new BoxShadow(
              color: Colors.black12,
              offset: Offset.fromDirection(20, 7),
              blurRadius: 3.0,
              spreadRadius: 0.1
          )
        ],
        borderRadius: BorderRadius.all(Radius.circular(20)),
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          stops: [0.1, 0.4],
          colors: [Colors.red, Colors.white],
        ),
      ),
      child: InkWell(
        child: Text('CBD section'),
        onTap: () {
          HapticFeedback.vibrate();
          Navigator.of(context).pushReplacementNamed('/cbd');
        },
      ),
    );
  }
}