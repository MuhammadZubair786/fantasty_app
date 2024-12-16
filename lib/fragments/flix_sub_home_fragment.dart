import 'package:fantasyapp/models/flix_response.dart';
import 'package:fantasyapp/screens/flix_movie_detail_screen_2.dart';
import 'package:fantasyapp/screens/flix_series_detail_screen.dart';
import 'package:fantasyapp/screens/flix_view_all_movies_screen.dart';
import 'package:fantasyapp/utils/flix_app_widgets.dart';
import 'package:fantasyapp/utils/flix_data_generator.dart';
import 'package:fantasyapp/utils/flix_slider_widget.dart';
import 'package:fantasyapp/utils/resources/flix_colors.dart';
import 'package:fantasyapp/utils/resources/flix_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';


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

  getData() {
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
  }

  @override
  Widget build(BuildContext context) {
    var slider = mSliderList.isNotEmpty ? HomeSliderWidget(mSliderList) : Container();
    var madeForYouSlider = mMadeForYouList.isNotEmpty ? VerticalSliderWidget(mMadeForYouList) : Container();
    var popularMovieList = mMovieList.isNotEmpty ? ItemHorizontalList(mMovieList, isHorizontal: false) : Container();
    var trendingMovieList = mTrendingMuviList.isNotEmpty ? ItemHorizontalList(mTrendingMuviList, isHorizontal: false) : Container();
    var newCinemaList = mCinemaMovieList.isNotEmpty ? ItemHorizontalList(mCinemaMovieList, isHorizontal: true) : Container();
    var continueWatchingList = mcontinueList.isNotEmpty ? ItemProgressHorizontalList(mcontinueList) : Container();
    return Scaffold(
      backgroundColor: muvi_appBackground,
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                headingText(context, "Trending this week").paddingAll(spacing_standard_new),
                slider,
                headingText(context, "Top Leaguges").paddingOnly(
                  left: spacing_standard_new,
                  right: spacing_standard_new,
                  top: 12,
                  bottom: spacing_standard_new,
                ),
                 SizedBox(
              height: 200,
              child: TopFeatureList(),
            ),
                 headingText(context, "Top Teams").paddingOnly(
                  left: spacing_standard_new,
                  right: spacing_standard_new,
                  top: 12,
                  bottom: spacing_standard_new,
                ),
                 TopTeam(),
                headingText(context, "All Leaguges").paddingOnly(
                  left: spacing_standard_new,
                  right: spacing_standard_new,
                  top: 12,
                  bottom: spacing_standard_new,
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
            ),
          ),
          Center(child: loadingWidgetMaker().visible(isLoading))
        ],
      ),
    );
  }

  ListView ALLleaguges() {
    return ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: allLeagues.length,
            itemBuilder: (context, index) {
              final league = allLeagues[index];
              return Card(
                color: Colors.grey[900],
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
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
                        league["description"]!,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
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
              itemCount: topTeams.length,
              itemBuilder: (context, index) {
                final team = topTeams[index];
                return Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: NetworkImage(team["image"]!),
                      ),
                      SizedBox(height: 8),
                      Text(
                        team["name"]!,
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
                    child: Container(
                      width: 300,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
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
  List<HomeSlider> mSliderList;

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
                  slider.slideImage,
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
                ).paddingOnly(left: spacing_standard, bottom: spacing_standard_new)
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
