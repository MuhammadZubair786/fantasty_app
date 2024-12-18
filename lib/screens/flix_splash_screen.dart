import 'dart:async';

import 'package:fantasyapp/main.dart';
import 'package:fantasyapp/screens/flix_onboarding_screen.dart';
import 'package:fantasyapp/utils/resources/flix_colors.dart';
import 'package:fantasyapp/utils/resources/flix_images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';


class MuviSplashScreen extends StatefulWidget {
  static String tag = '/SplashScreen';

  @override
  MuviSplashScreenState createState() => MuviSplashScreenState();
}

class MuviSplashScreenState extends State<MuviSplashScreen> {
  startTime() async {
    var _duration = Duration(seconds: 3);
    return Timer(_duration, navigationPage);
  }

  void navigationPage() async {
    finish(context);
    MuviOnBoardingScreen().launch(context);
  }

  @override
  void initState() {
    setStatusBarColor(muvi_navigationBackground, statusBarIconBrightness: Brightness.light);
    startTime();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    setStatusBarColor(appStore.isDarkModeOn ? cardDarkColor : white, statusBarIconBrightness: Brightness.light);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: muvi_navigationBackground,
        body: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Image.asset(ic_logo, width: MediaQuery.of(context).size.width * 0.9,color: muvi_colorPrimary,),
              )
            ],
          ).center(),
        ),
      ),
    );
  }
}
