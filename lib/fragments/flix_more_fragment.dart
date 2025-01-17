import 'package:fantasyapp/screens/flix_account_settings_screen.dart';
import 'package:fantasyapp/screens/flix_edit_profile_screen.dart';
import 'package:fantasyapp/screens/flix_help_screen.dart';
import 'package:fantasyapp/screens/flix_terms_conditions_screen.dart';
import 'package:fantasyapp/screens/privacy_policy.dart';
import 'package:fantasyapp/utils/flix_app_widgets.dart';
import 'package:fantasyapp/utils/flix_constants.dart';
import 'package:fantasyapp/utils/resources/flix_colors.dart';
import 'package:fantasyapp/utils/resources/flix_images.dart';
import 'package:fantasyapp/utils/resources/flix_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';


class MoreFragment extends StatefulWidget {
  static String tag = '/MoreFragment';

  @override
  MoreFragmentState createState() => MoreFragmentState();
}

class MoreFragmentState extends State<MoreFragment> {
  var profileImage = "";
  var userName = "";
  var userEmail = "";
  bool? isDarkMode = true;

  @override
  void initState() {
    super.initState();
    setStatusBarColor(muvi_navigationBackground, statusBarIconBrightness: Brightness.light);
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: muvi_appBackground,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        //  leading: GestureDetector(
        //   onTap: (){
        //     Navigator.pop(context);
        //   },
        //   child: Icon(Icons.arrow_back,color: Colors.white,)),
        title: Center(child: toolBarTitle(context, "Setting")),
        backgroundColor: muvi_navigationBackground,
        elevation: 0,
        iconTheme: IconThemeData(color: white),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: muvi_navigationBackground,
            padding: EdgeInsets.only(
              left: spacing_standard_new,
              top: spacing_standard_new,
              right: 12,
              bottom: spacing_standard_new,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(radius: 30, child: CircleAvatar(child: networkImage(profileImage))).paddingRight(spacing_standard_new),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      text(userName, fontSize: ts_extra_normal, fontFamily: font_bold, textColor: muvi_textColorPrimary),
                      text(userEmail, fontSize: ts_normal, fontFamily: font_medium, textColor: muvi_textColorSecondary)
                    ],
                  ),
                ),
                // Image.asset(
                //   ic_edit_profile,
                //   width: 20,
                //   height: 20,
                //   color: muvi_colorPrimary,
                // ).paddingAll(spacing_control).onTap(
                //   () {
                //     EditProfileScreen().launch(context);
                //   },
                // )
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  itemSubTitle(
                    context,
                    "General Settings",
                    colorThird: false,
                  ).paddingOnly(left: spacing_standard_new, right: spacing_standard_new, top: 12, bottom: 12),
                  // subType(context, "Account Settings", () {
                  //   AccountSettingsScreen().launch(context);
                  // }, ic_settings),
                 
                    
                  subType(context, "Language", () {}, ic_language),
                  subType(context, "Help", () {
                    HelpScreen().launch(context);
                  }, ic_help),
                  itemSubTitle(context, "Terms").paddingOnly(
                    left: spacing_standard_new,
                    right: 16,
                    top: spacing_standard_new,
                    bottom: spacing_control,
                  ),
                  subType(context, "Terms & Conditions", () {
                    TermsConditionsScreen().launch(context);
                  }, null),
                  subType(context, "Privacy & Policy", () {
                    PrivacyPolicyScreen().launch(context);
                  }, null),
                  subType(context, "Logout", () {
                    finish(context);
                  }, null),
                ],
              ).paddingBottom(spacing_large),
            ),
          )
        ],
      ),
    );
  }

  Future<void> getUserData() async {
 final prefs = await SharedPreferences.getInstance();
        var email = prefs.getString("user_email");
    setState(
      () {
        profileImage = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT_ZWw4uRMopVRm6qcPDmQqdd7HugVFwgNNhg&s";
        userName =email.toString().substring(0,4);
        userEmail = email.toString();
      },
    );
  }
}
