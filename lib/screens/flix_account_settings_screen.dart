import 'package:fantasyapp/screens/flix_change_password.dart';
import 'package:fantasyapp/utils/flix_app_widgets.dart';
import 'package:fantasyapp/utils/resources/flix_colors.dart';
import 'package:fantasyapp/utils/resources/flix_images.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';


class AccountSettingsScreen extends StatefulWidget {
  static String tag = '/AccountSettingsScreen';

  @override
  AccountSettingsScreenState createState() => AccountSettingsScreenState();
}

class AccountSettingsScreenState extends State<AccountSettingsScreen> {
  @override
  void initState() {
    super.initState();
    setStatusBarColor(
      muvi_navigationBackground,
      statusBarIconBrightness: Brightness.light,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: muvi_appBackground,
        appBar: appBarLayout(context, "Account Settings"),
        body: SingleChildScrollView(
          child: Column(
            children: [
              subType(context, "Change Password", () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ChangePasswordScreen()));
              }, ic_password),
              subType(context, "Video Quality", () {}, ic_video),
              subType(context, "Download Settings", () {}, ic_download),
            ],
          ),
        ),
      ),
    );
  }
}
