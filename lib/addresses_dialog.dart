
import 'package:flutter/material.dart';
import 'package:healthplus/assets.dart';
import 'package:healthplus/logger.dart';
import 'package:healthplus/ui_constants.dart';

class AboutUsDialog extends StatelessWidget {
  final Log log = new Log('AboutUsDialog');

  AboutUsDialog();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.only(left:30, top:50, bottom: 80, right:30),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      elevation: 0.0,
      backgroundColor: Colors.white,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    return Stack(
        overflow: Overflow.visible,
        alignment: Alignment.topCenter,
        children: <Widget>[
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
                padding: EdgeInsets.only(top: 30, bottom: 40, left: 25, right: 25),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('ADDRESSES',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: UiConstants.primaryColor
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    _buildAddressColumn()

                  ],
                )
            ),
          )
          ]
    );
  }

  Widget _buildAddressColumn() {
    List<Widget> _adds = [];
    Assets.chfEquipmentAddress.forEach((cAdd) {
      _adds.add(
          Padding(
            padding: EdgeInsets.fromLTRB(5,10,5,10),
              child:Container(
            padding: EdgeInsets.all(10),
            width: double.infinity,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                new BoxShadow(
                    color: Colors.black12,
                    offset: Offset.fromDirection(20, 7),
                    blurRadius: 2.0,
                    spreadRadius: 0.1
                )
              ],
              borderRadius: BorderRadius.all(Radius.circular(20)),
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                stops: [0.1, 0.4],
                colors: [Colors.white, Colors.white],
              ),
            ),
            child: Center(
              child: Text(cAdd,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                  color: Colors.black,
                  height: 1.4
                ),
              ),
            ),
          ))
      );
    });
    return Padding(
        padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: _adds
          ),
        )
      //),
    );
  }
}
