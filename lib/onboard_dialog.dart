import 'package:flutter/material.dart';
import 'package:healthplus/assets.dart';
import 'package:healthplus/logger.dart';
import 'package:healthplus/ui_constants.dart';

class OnboardDialog extends StatefulWidget {

  @override
  State createState() => OnboardDialogState();

  OnboardDialog({this.imagePath, this.title});

  final String title;
  final String imagePath;
}

class OnboardDialogState extends State<OnboardDialog> {
  final Log log = new Log('OnboardDialog');

  OnboardDialogState();

  @override
  void initState(){
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(UiConstants.padding),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    return Stack(
      children: <Widget>[
        //...bottom card part,
        Container(
          width: double.infinity,
          padding: EdgeInsets.only(
            top: UiConstants.padding + 30,
            bottom: UiConstants.padding + 30,
            left: UiConstants.padding,
            right: UiConstants.padding,
          ),
          //margin: EdgeInsets.only(top: UiConstants.avatarRadius),
          decoration: new BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(UiConstants.padding),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: const Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // To make the card compact
            children: <Widget>[
              SizedBox(
                child: Image(
                  image: AssetImage(widget.imagePath),
                  fit: BoxFit.contain,
                ),
                width: 200,
                height: 200,
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.only(left:20, right:20),
                child: Text(widget.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w300
                ),
                )
              )
            ],
          ),
          )

      ],
    );
  }

}
