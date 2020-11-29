import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:healthplus/assets.dart';
import 'package:healthplus/constants.dart';
import 'package:healthplus/light_color.dart';
import 'package:healthplus/ui_constants.dart';

class AppRoot extends StatefulWidget {
  @override
  State createState() => _AppRootState();
}

class _AppRootState extends State<AppRoot> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightColor.skyBlue,
      appBar: AppBar(
        elevation: 1.0,
        backgroundColor: LightColor.skyBlue,
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
                  child: _buildHealthSectionWidget()),
            ),
            Expanded(
              child: Padding(
                  padding: EdgeInsets.all(10),
                  child: _buildHealth2SectionWidget()),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHealthSectionWidget() {
    return Stack(children: [
      Opacity(
          opacity: 0.2,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              image: DecorationImage(
                image: AssetImage(Assets.neoNatalImagePath[3]),
                fit: BoxFit.fill,
                //colorFilter: new ColorFilter.mode(Colors.purple.withOpacity(1.0), BlendMode.softLight),
              ),
            ),
          )),
      Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: Colors.red,
          boxShadow: [
            new BoxShadow(
                color: Colors.black12,
                offset: Offset.fromDirection(20, 7),
                blurRadius: 3.0,
                spreadRadius: 0.1)
          ],
          borderRadius: BorderRadius.all(Radius.circular(20)),
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: [0.1, 0.8],
            colors: [Colors.greenAccent, Colors.transparent],
          ),
        ),
        child: InkWell(
          child: Center(
            child: Text(
              'Neonatal section',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 36,
                  color: Colors.white),
            ),
          ),
          onTap: () {
            HapticFeedback.vibrate();
            Navigator.of(context).pushNamed('/neonatal');
          },
        ),
      ),
    ]);
  }

  Widget _buildHealth2SectionWidget() {
    return Stack(children: [
      Opacity(
          opacity: 0.2,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              image: DecorationImage(
                image: AssetImage(Assets.chfImagePath[2]),
                fit: BoxFit.fill,
                //colorFilter: new ColorFilter.mode(Colors.purple.withOpacity(1.0), BlendMode.softLight),
              ),
            ),
          )),
      Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: Colors.red,
          boxShadow: [
            new BoxShadow(
                color: Colors.black12,
                offset: Offset.fromDirection(20, 7),
                blurRadius: 3.0,
                spreadRadius: 0.1)
          ],
          borderRadius: BorderRadius.all(Radius.circular(20)),
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: [0.1, 0.8],
            colors: [Colors.blueAccent, Colors.transparent],
          ),
        ),
        child: InkWell(
          child: Center(
            child: Text(
              'CHF section',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 36,
                  color: Colors.white),
            ),
          ),
          onTap: () {
            HapticFeedback.vibrate();
            Navigator.of(context).pushNamed('/cbd');
          },
        ),
      ),
    ]);
  }
}
