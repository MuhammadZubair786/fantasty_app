import 'package:fantasyapp/models/flix_response.dart';
import 'package:fantasyapp/utils/flix_app_widgets.dart';
import 'package:fantasyapp/utils/flix_data_generator.dart';
import 'package:fantasyapp/utils/resources/flix_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';


// ignore: must_be_immutable
class ViewAllMovieScreen extends StatefulWidget {
  static String tag = '/ViewAllMovieScreen';
  String? title = "";

  ViewAllMovieScreen({this.title});

  @override
  ViewAllMovieScreenState createState() => ViewAllMovieScreenState();
}

class ViewAllMovieScreenState extends State<ViewAllMovieScreen> {
  List<Movie> movieList = [];

  @override
  void initState() {
    super.initState();
    setStatusBarColor(muvi_navigationBackground, statusBarIconBrightness: Brightness.light);
    movieList.addAll(getMadeForYouMovie());
  }

  @override
  void dispose() {
    super.dispose();
    setStatusBarColor(muvi_navigationBackground, statusBarIconBrightness: Brightness.light);
  }

  @override
  Widget build(BuildContext context) {
    var allMovieList = AllMovieGridList(movieList);
    return SafeArea(
      child: Scaffold(
        backgroundColor: muvi_appBackground,
        appBar: appBarLayout(context, widget.title),
        body: allMovieList,
      ),
    );
  }
}
