import 'dart:collection';

import 'package:fantasyapp/fragments/flix_home_fragment.dart';
import 'package:fantasyapp/fragments/flix_more_fragment.dart';
import 'package:fantasyapp/fragments/flix_my_files_fragment.dart';
import 'package:fantasyapp/fragments/flix_search_fragment.dart';
import 'package:fantasyapp/fragments/roaster_mangement.dart';
import 'package:fantasyapp/utils/flix_bottom_navigation.dart';
import 'package:fantasyapp/utils/resources/flix_colors.dart';
import 'package:fantasyapp/utils/resources/flix_images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';


class HomeScreen extends StatefulWidget {
  static String tag = '/HomeScreen';

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  var _selectedIndex = 0;
  var homeFragment = HomeFragment();
  var searchFragment = SearchFragment();
  var myFilesFragment = RosterManagementScreen();
  var moreFragment = MoreFragment();
  late List<Widget> viewContainer;
  ListQueue<int> _navigationQueue = ListQueue();

  @override
  void initState() {
    super.initState();
    viewContainer = [homeFragment, searchFragment, myFilesFragment, moreFragment];
    setStatusBarColor(
      muvi_navigationBackground,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.light,
    );
  }

  void _onItemTapped(int index) {
    _navigationQueue.addLast(index);
    setState(
      () {
        _selectedIndex = index;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_selectedIndex == 0) return true;
        setState(() {
          _selectedIndex = 0;
          _navigationQueue.removeLast();
        });
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: muvi_appBackground,
          body: viewContainer[_selectedIndex],
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: muvi_navigationBackground,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.05),
                  offset: Offset.fromDirection(3, 1),
                  spreadRadius: 3,
                  blurRadius: 5,
                ),
              ],
            ),
            child: AppBottomNavigationBar(
              backgroundColor: muvi_navigationBackground,
              items: const <AppBottomNavigationBarItem>[
                AppBottomNavigationBarItem(icon: ic_home),
                AppBottomNavigationBarItem(icon: ic_search),
                AppBottomNavigationBarItem(icon: ic_folder),
                AppBottomNavigationBarItem(icon: ic_more),
              ],
              currentIndex: _selectedIndex,
              unselectedIconTheme: IconThemeData(color: muvi_textColorPrimary, size: 22),
              selectedIconTheme: IconThemeData(color: muvi_colorPrimary, size: 22),
              onTap: _onItemTapped,
              type: AppBottomNavigationBarType.fixed,
            ),
          ),
        ),
      ),
    );
  }
}
