import 'package:fantasyapp/screens/flix_faq_screen.dart';
import 'package:fantasyapp/utils/flix_app_widgets.dart';
import 'package:fantasyapp/utils/resources/flix_colors.dart';
import 'package:fantasyapp/utils/resources/flix_images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class HelpScreen extends StatefulWidget {
  static String tag = '/HelpScreen';

  @override
  HelpScreenState createState() => HelpScreenState();
}

class HelpScreenState extends State<HelpScreen> {
  @override
  void initState() {
    super.initState();
    setStatusBarColor(muvi_navigationBackground, statusBarIconBrightness: Brightness.light);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: muvi_appBackground,
        appBar: appBarLayout(context, "Help"),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              subType(context, "Report Problem", () {}, ic_report),
              subType(context, "Help Center", () {}, ic_help),
              subType(context, "FAQ", () {
                FaqScreen().launch(context);
              }, ic_faq),
            ],
          ),
        ),
      ),
    );
  }
}
