import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:healthplus/addresses_dialog.dart';
import 'package:healthplus/assets.dart';
import 'package:healthplus/constants.dart';
import 'package:healthplus/light_color.dart';
import 'package:healthplus/model/dactor_model.dart';
import 'package:healthplus/model/data.dart';
import 'package:healthplus/onboard_dialog.dart';
import 'package:healthplus/text_styles.dart';
import 'package:healthplus/theme.dart';
import 'package:healthplus/ui_constants.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.pageType}) : super(key: key);

  final int pageType;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<DoctorModel> doctorDataList;

  @override
  void initState() {
    doctorDataList = doctorMapList.map((x) => DoctorModel.fromJson(x)).toList();
    super.initState();
  }

  Widget _appBar() {
    return AppBar(
      elevation: 0.0,
      backgroundColor: Theme.of(context).backgroundColor,
      iconTheme: IconThemeData(
        color: UiConstants.accentColor, //change your color here
      ),
      title: Text('',
          style: TextStyle(
              color: UiConstants.accentColor,
              fontWeight: FontWeight.w700,
              fontSize: 30.0)),
    );
  }

  Widget _header() {
    return Padding(
      padding: EdgeInsets.only(left:20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Hello,",
              style:
              TextStyles.title.copyWith(color: LightColor.extraLightBlue)),
          Text("Suraaj Ray Lala", style: TextStyles.h1Style),
        ],
      )
    );
  }

  Widget _searchField() {
    return Container(
      height: 55,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(13)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: LightColor.grey.withOpacity(.3),
            blurRadius: 15,
            offset: Offset(5, 5),
          )
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            border: InputBorder.none,
            hintText: "Search",
            hintStyle:
                TextStyles.body.copyWith(color: LightColor.subTitleTextColor),
            suffixIcon: SizedBox(
                width: 50, child: Icon(Icons.search, color: LightColor.purple))
            //.alignCenter
            //.ripple(() {}, borderRadius: BorderRadius.circular(13))),
            ),
      ),
    );
  }

  Widget _category() {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 8, right: 16, left: 16, bottom: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Category",
                  style:
                      TextStyles.title.copyWith(fontWeight: FontWeight.bold)),
              Text(
                "See All",
                style: TextStyles.titleNormal
                    .copyWith(color: Theme.of(context).primaryColor),
              ) //.p(8).ripple(() {})
            ],
          ),
        ),
        SizedBox(
          height: AppTheme.fullHeight(context) * .28,
          width: AppTheme.fullWidth(context),
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              InkWell(
                  child:_categoryCard("Find a speacialist", "150+ Clinics",
                  color: LightColor.green, lightColor: LightColor.lightGreen),
                onTap: () {
                    HapticFeedback.vibrate();
                    showDialog(
                        context: context,
                        builder: (BuildContext context) => AboutUsDialog()
                    );
                },

              ),
              _categoryCard("Have a tele-consultation", "80+ Doctors",
                  color: LightColor.skyBlue, lightColor: LightColor.lightBlue),
              _categoryCard("Book an appointment", "9AM to 7PM",
                  color: LightColor.orange, lightColor: LightColor.lightOrange)
            ],
          ),
        ),
      ],
    );
  }

  Widget _categoryCard(String title, String subtitle,
      {Color color, Color lightColor}) {
    TextStyle titleStyle = TextStyles.title
        .copyWith(color: Colors.white, fontWeight: FontWeight.bold);
    TextStyle subtitleStyle = TextStyles.body
        .copyWith(color: Colors.white, fontWeight: FontWeight.bold);
    if (AppTheme.fullWidth(context) < 392) {
      titleStyle = TextStyles.body
          .copyWith(color: Colors.white, fontWeight: FontWeight.bold);
      subtitleStyle = TextStyles.bodySm
          .copyWith(color: Colors.white, fontWeight: FontWeight.bold);
    }
    return AspectRatio(
      aspectRatio: 6 / 8,
      child: Container(
        height: 280,
        width: AppTheme.fullWidth(context) * .3,
        margin: EdgeInsets.only(left: 10, right: 10, bottom: 20, top: 10),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              offset: Offset(4, 4),
              blurRadius: 10,
              color: lightColor.withOpacity(.8),
            )
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          child: Container(
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: -20,
                  left: -20,
                  child: CircleAvatar(
                    backgroundColor: lightColor,
                    radius: 60,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Flexible(
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child:Text(title, style: titleStyle)), //.hP8,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Flexible(
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          subtitle,
                          style: subtitleStyle,
                        ),
                      ), //.hP8,
                    ),
                  ],
                ), //.p16
              ],
            ),
          ),
        ), //.ripple(() {}, borderRadius: BorderRadius.all(Radius.circular(20))),
      ),
    );
  }

  Widget _doctorsList() {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text("Top Devices",
                    style:
                    TextStyles.title.copyWith(fontWeight: FontWeight.bold)),
              ),
              IconButton(
                  icon: Icon(
                    Icons.sort,
                    color: Theme.of(context).primaryColor,
                  ),
                  onPressed: () {})
              // .p(12).ripple(() {}, borderRadius: BorderRadius.all(Radius.circular(20))),
            ],
          ), //.hP16,
          getdoctorWidgetList()
        ],
      ),
    );
  }

  Widget getdoctorWidgetList() {
    List<Widget> kids = [];
    if (widget.pageType == 0) {
      for (int i = 0; i < Assets.neoNatalDeviceLabels.length; i++) {
        kids.add(InkWell(
          child: _doctorTile(
              Assets.neoNatalImagePath[i], Assets.neoNatalDeviceLabels[i]),
          onTap: () {
            HapticFeedback.vibrate();
            showDialog(
                context: context,
                builder: (BuildContext context) => OnboardDialog(imagePath:Assets.neoNatalImagePath[i], title: Assets.neoNatalDeviceLabels[i])
            );
          },
        ));
      }
    } else {
      for (int i = 0; i < Assets.chfLabels.length; i++) {
        kids.add(InkWell(
          child: _doctorTile(Assets.chfImagePath[i], Assets.chfLabels[i]),
          onTap: () {
            HapticFeedback.vibrate();
            showDialog(
                context: context,
                builder: (BuildContext context) => OnboardDialog(imagePath: Assets.chfImagePath[i], title: Assets.chfLabels[i])
            );
          },
        ));
      }
    }
    return Column(children: kids);
  }

  Widget _doctorTile(String xImage, String xName) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              offset: Offset(4, 4),
              blurRadius: 10,
              color: LightColor.grey.withOpacity(.2),
            ),
            BoxShadow(
              offset: Offset(-3, 0),
              blurRadius: 15,
              color: LightColor.grey.withOpacity(.1),
            )
          ],
        ),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
          child: ListTile(
            contentPadding: EdgeInsets.all(0),
            leading: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(13)),
              child: Container(
                height: 55,
                width: 55,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: randomColor(),
                ),
                child: Image.asset(
                  xImage,
                  height: 50,
                  width: 50,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            title: Text(xName,
                style: TextStyles.title.copyWith(fontWeight: FontWeight.bold)),
            subtitle: Text(
              'See More',
              style: TextStyles.bodySm.copyWith(
                  color: LightColor.subTitleTextColor,
                  fontWeight: FontWeight.bold),
            ),
            trailing: Icon(
              Icons.keyboard_arrow_right,
              size: 30,
              color: Theme.of(context).primaryColor,
            ),
          ),
        )
        //     .ripple(() {
        //   Navigator.pushNamed(context, "/DetailPage", arguments: model);
        // }, borderRadius: BorderRadius.all(Radius.circular(20))),
        );
  }

  Color randomColor() {
    var random = Random();
    final colorList = [
      Theme.of(context).primaryColor,
      LightColor.orange,
      LightColor.green,
      LightColor.grey,
      LightColor.lightOrange,
      LightColor.skyBlue,
      LightColor.titleTextColor,
      Colors.red,
      Colors.brown,
      LightColor.purpleExtraLight,
      LightColor.skyBlue,
    ];
    var color = colorList[random.nextInt(colorList.length)];
    return color;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      backgroundColor: Theme.of(context).backgroundColor,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate(
              [
                _header(),
                _searchField(),
                _category(),
              ],
            ),
          ),
          _doctorsList()
        ],
      ),
    );
  }
}
