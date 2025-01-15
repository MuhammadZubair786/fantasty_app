import 'package:fantasyapp/Controllers/firebase_data.dart';
import 'package:fantasyapp/models/flix_response.dart';
import 'package:fantasyapp/screens/flix_movie_detail_screen_2.dart';
import 'package:fantasyapp/screens/flix_series_detail_screen.dart';
// import 'package:fantasyapp/screens/flix_view_all_movies_screen.dart';
import 'package:fantasyapp/utils/flix_app_widgets.dart';
import 'package:fantasyapp/utils/flix_constants.dart';
import 'package:fantasyapp/utils/flix_data_generator.dart';
import 'package:fantasyapp/utils/flix_slider_widget.dart';
import 'package:fantasyapp/utils/resources/flix_colors.dart';
import 'package:fantasyapp/utils/resources/flix_size.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:skeletonizer/skeletonizer.dart';

// ignore: must_be_immutable
class HomeCategoryFragment extends StatefulWidget {
  static String tag = '/SubHomeFragment';
  var type;

  HomeCategoryFragment({this.type});

  @override
  HomeCategoryFragmentState createState() => HomeCategoryFragmentState();
}

class HomeCategoryFragmentState extends State<HomeCategoryFragment> {
  List<HomeSlider> mSliderList = [];
  List<Movie> mMovieList = [];
  List<Movie> mCinemaMovieList = [];
  List<Movie> mcontinueList = [];
  List<Movie> mTrendingMuviList = [];
  List<Movie> mMadeForYouList = [];
  bool isLoading = false;

  var leaguges = [];
  var Teams = [];
  var Standing = [];

  var loading = false;

  showLoading(bool show) {
    setState(
      () {
        isLoading = show;
      },
    );
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    showLoading(true);
    
    await FirestoreService()
        .getAllLeagues()
        .then((value) => {leaguges.addAll(value)});

    await FirestoreService()
        .getAllTeams()
        .then((value) => {Teams.addAll(value)});

    await FirestoreService()
        .getStandings()
        .then((value) => {Standing.addAll(value)});

    setState(
      () {
        mSliderList.addAll(getSliders());
        mMovieList.addAll(getMovie());
        mCinemaMovieList.addAll(getHorizontalMovie());
        mcontinueList.addAll(getContinueMovies());
        mTrendingMuviList.addAll(getTrendingOnMovie());
        mMadeForYouList.addAll(getMadeForYouMovie());
      },
    );
    showLoading(false);
  }

  @override
  Widget build(BuildContext context) {
    var slider = leaguges.isNotEmpty ? HomeSliderWidget(loading ? mSliderList : leaguges) : Container();

    return Scaffold(
      backgroundColor: muvi_appBackground,
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
              child: BuildDynamicUi(slider)),
          Center(child: loadingWidgetMaker().visible(isLoading))
        ],
      ),
    );
  }


 
  Column BuildDynamicUi(StatelessWidget slider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(12.0),
          child: Padding(
            padding: EdgeInsets.only(
                left: 10.0, right: 20.0), // Extra space on the right
            child: Stack(
              children: [
                Positioned(
                  bottom: 0, // Position underline closer to the text
                  child: Container(
                    width:
                        80, // Adjust width as per the text length or set it dynamically
                    height: 2.0, // Thickness of the underline
                    color: muvi_colorPrimary, // Underline color
                  ),
                ),
                Text(
                  "Leagues",
                  textAlign: TextAlign.justify,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: ts_extra_normal,
                    fontFamily: font_bold,
                    height: 2,
                    color: muvi_textColorPrimary,
                  ),
                ),
              ],
            ),
          ),
        ),

        // headingText(context, "Leaguges",).paddingAll(spacing_standard_new),
        slider,

        Padding(
          padding: EdgeInsets.all(12.0),
          child: Padding(
            padding: EdgeInsets.only(
                left: 10.0, right: 20.0), // Extra space on the right
            child: Stack(
              children: [
                Positioned(
                  bottom: 0, // Position underline closer to the text
                  child: Container(
                    width:
                        100, // Adjust width as per the text length or set it dynamically
                    height: 3.0, // Thickness of the underline
                    color: muvi_colorPrimary, // Underline color
                  ),
                ),
                Text(
                  "Teams",
                  textAlign: TextAlign.justify,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: ts_extra_normal,
                    fontFamily: font_bold,
                    height: 2,
                    color: muvi_textColorPrimary,
                  ),
                ),
              ],
            ),
          ),
        ),

        TopTeam(),
        Padding(
          padding: EdgeInsets.all(12.0),
          child: Padding(
            padding: EdgeInsets.only(
                left: 10.0, right: 20.0), // Extra space on the right
            child: Stack(
              children: [
                Positioned(
                  bottom: 0, // Position underline closer to the text
                  child: Container(
                    width:
                        160, // Adjust width as per the text length or set it dynamically
                    height: 2.0, // Thickness of the underline
                    color: muvi_colorPrimary, // Underline color
                  ),
                ),
                Text(
                  "Standing",
                  textAlign: TextAlign.justify,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: ts_extra_normal,
                    fontFamily: font_bold,
                    height: 2,
                    color: muvi_textColorPrimary,
                  ),
                ),
              ],
            ),
          ),
        ),

        ALLleaguges(),
        // headingWidViewAll(
        //   context,
        //   "Tending on Muvi",
        //   () {
        //     ViewAllMovieScreen(title: "New on Cinemas").launch(context);
        //   },
        // ).paddingAll(spacing_standard_new),
        // trendingMovieList.paddingBottom(spacing_standard_new)
      ],
    );
  }

  ListView ALLleaguges() {
    return loading ? ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: mMovieList.length,
      itemBuilder: (context, index) {
        final league = mMovieList[index];
        return Container(
          child: Card(
            elevation: 10,
            color: Colors.grey[900],
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    league.title!,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 4),

                  Text(
                    league.subTitle!,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[400],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    ):ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: Standing.length,
      itemBuilder: (context, index) {
        final league = Standing[index];
        return Container(
          child: Card(
            elevation: 10,
            color: Colors.grey[900],
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    league["leagueName"]!,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 4),
//                 
                  Text(
                    league["description"]!,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[400],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  SizedBox TopTeam() {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: Teams.length,
        itemBuilder: (context, index) {
          final team = Teams[index];
          return Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(team["teamLogo"]!),
                ),
                SizedBox(height: 8),
                Text(
                  team["teamName"]!,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  ListView TopFeatureList() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: featuredLeagues.length,
      itemBuilder: (context, index) {
        final league = featuredLeagues[index];
        return Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: Card(
            color: Colors.grey[900],
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0)),
            child: Container(
              width: 300,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(16.0)),
                    child: Image.network(
                      league["image"]!,
                      height: 120,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          league["name"]!,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          league["details"]!,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[400],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// ignore: must_be_immutable
class HomeSliderWidget extends StatelessWidget {
  List mSliderList;


  HomeSliderWidget(this.mSliderList);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    width = width - 36;
    final Size cardSize = Size(width, width / 1.5);
    return SliderWidget(
      height: cardSize.height,
      enlargeCenterPage: true,
      scrollDirection: Axis.horizontal,
      items: mSliderList.map((slider) {
        return Builder(
          builder: (BuildContext context) {
            return Stack(
              alignment: Alignment.bottomLeft,
              children: <Widget>[
                networkImage(
                  slider["imageUrl"],
                  aWidth: cardSize.width,
                  aHeight: cardSize.height,
                  // fit: BoxFit.cover,
                ).cornerRadiusWithClipRRect(8),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // Row(
                    //   children: <Widget>[
                    //     hdWidget(context).paddingRight(spacing_standard).visible(slider.isHD!),
                    //     itemSubTitle(context, "2018"),
                    //     itemSubTitle(context, "17+").paddingLeft(spacing_standard)
                    //   ],
                    // ).paddingTop(spacing_control_half)
                  ],
                ).paddingOnly(
                    left: spacing_standard, bottom: spacing_standard_new)
              ],
            ).paddingBottom(spacing_control).onTap(
              () {
                SeriesDetailScreen().launch(context);
              },
            );
          },
        );
      }).toList(),
    );
  }
}

// ignore: must_be_immutable
class VerticalSliderWidget extends StatelessWidget {
  List<Movie> mSliderList;

  VerticalSliderWidget(this.mSliderList);

  @override
  Widget build(BuildContext context) {
    var width = context.width();
    width = width * 0.7;
    final Size cardSize = Size(width, width * (16 / 11.5));
    return SliderWidget(
      viewportFraction: 0.65,
      height: 250,
      enlargeCenterPage: true,
      scrollDirection: Axis.horizontal,
      items: mSliderList.map(
        (slider) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                width: cardSize.width,
                margin: EdgeInsets.symmetric(horizontal: spacing_control),
                child: Stack(
                  alignment: Alignment.bottomLeft,
                  children: <Widget>[
                    networkImage(
                      slider.slideImage,
                      aWidth: context.width() * 0.85,
                      fit: BoxFit.cover,
                    ).cornerRadiusWithClipRRect(8),
                  ],
                ).paddingBottom(spacing_control),
              ).onTap(
                () {
                  MovieDetail2Screen(title: "Action").launch(context);
                },
              );
            },
          );
        },
      ).toList(),
    );
  }
}
