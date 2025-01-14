import 'package:fantasyapp/fragments/create_leaguge_new.dart';
import 'package:fantasyapp/fragments/flix_leageue_matches.dart';
import 'package:fantasyapp/fragments/flix_sub_home_fragment.dart';
import 'package:fantasyapp/fragments/join_leaguge.dart';
import 'package:fantasyapp/main.dart';
import 'package:fantasyapp/utils/flix_app_widgets.dart';
import 'package:fantasyapp/utils/flix_constants.dart';
import 'package:fantasyapp/utils/resources/flix_colors.dart';
import 'package:fantasyapp/utils/resources/flix_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class HomeFragment extends StatefulWidget {
  static String tag = '/HomeFragment';

  @override
  HomeFragmentState createState() => HomeFragmentState();
}

class HomeFragmentState extends State<HomeFragment> {
  @override
  void initState() {
    super.initState();
    changeStatusColor(muvi_appBackground);
  }

  

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: muvi_appBackground,
        appBar: AppBar(
          elevation: 0,
          iconTheme: IconThemeData(color: appStore.isDarkModeOn ? white : black),
          backgroundColor: muvi_navigationBackground,
          centerTitle: false,
          leading: flixTitle2(context),
          actions: [notificationIcon(context, 2)],
          bottom: const PreferredSize(
            preferredSize: Size(double.infinity, 45),
            child: Align(
              alignment: Alignment.topLeft,
              child: TabBar(
                indicatorPadding: EdgeInsets.only(left: 30, right: 30),
                indicatorWeight: 3.0,
                isScrollable: true,
                indicatorSize: TabBarIndicatorSize.tab,
                labelStyle: TextStyle(fontFamily: font_medium, fontSize: ts_normal),
                indicatorColor: muvi_colorPrimary,
                unselectedLabelColor: muvi_textColorPrimary,
                labelColor: muvi_colorPrimary,
                labelPadding: EdgeInsets.only(left: spacing_large, right: spacing_large),
                tabs: [
                  Tab(child: Text("Ongoing Leagues")),
                  Tab(child: Text("Active Matchups")),
                  Tab(child: Text("Create a League")),
                  Tab(child: Text("Join a League")),
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            HomeCategoryFragment(type: "Featured"),
           ActiveMatchupsPage(),
          CreateLeaguePage(),
           JoinLeaguesPage()
          ],
        ),
      ),
    );
  }
}
