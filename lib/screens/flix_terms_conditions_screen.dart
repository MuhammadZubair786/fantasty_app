import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fantasyapp/Controllers/firebase_data.dart';
import 'package:fantasyapp/utils/flix_app_widgets.dart';
import 'package:fantasyapp/utils/resources/flix_colors.dart';
import 'package:fantasyapp/utils/resources/flix_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class TermsConditionsScreen extends StatefulWidget {
  static String tag = '/TermsConditionsSceen';

  @override
  TermsConditionsScreenState createState() => TermsConditionsScreenState();
}

class TermsConditionsScreenState extends State<TermsConditionsScreen> {
  @override
  void initState() {
    super.initState();
    setStatusBarColor(muvi_navigationBackground,
        statusBarIconBrightness: Brightness.light);
    getTermAndCondition();
  }

  var terms = "";
  var loading = false;

  getTermAndCondition() async {
    setState(() {
      loading = true;
    });
    var res = await FirestoreService().getTermAndCondition();
    for (var i = 0; i < res.length; i++) {
      if (res[i]["type"] == "terms") {
        terms = res[i]["termscondition"];
        break;
      }
    }
    setState(() {
      loading = false;
    });
  }

  @override
  void dispose() {
    super.dispose();
    setStatusBarColor(muvi_navigationBackground,
        statusBarIconBrightness: Brightness.light);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: muvi_appBackground,
        appBar: appBarLayout(context, "Terms & Conditions"),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Fantasy Terms & conditions',
                style: boldTextStyle(color: Colors.white, size: 18),
              ).paddingBottom(spacing_standard),
              loading
                  ? Container(
                      height: 300,
                      child: Center(
                          child: CircularProgressIndicator(
                        color: Colors.white,
                      )))
                  : Text(
                      terms.toString(),
                      style: secondaryTextStyle(color: muvi_textColorSecondary),
                    )
            ],
          ).paddingAll(spacing_standard_new),
        ),
      ),
    );
  }
}
