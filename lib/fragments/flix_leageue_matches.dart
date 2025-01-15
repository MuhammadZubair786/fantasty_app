import 'dart:math';

import 'package:fantasyapp/Controllers/firebase_data.dart';
import 'package:fantasyapp/utils/flix_constants.dart';
import 'package:fantasyapp/utils/resources/flix_colors.dart';
import 'package:fantasyapp/utils/resources/flix_size.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../utils/flix_app_widgets.dart';

class ActiveMatchupsPage extends StatefulWidget {
  @override
  State<ActiveMatchupsPage> createState() => _ActiveMatchupsPageState();
}

class _ActiveMatchupsPageState extends State<ActiveMatchupsPage> {
  bool isLoading = false;

  var matches = [];

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
        .getAllMatches()
        .then((value) => {matches.addAll(value)});
    showLoading(false);
    print(matches);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 70,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Stack(
                children: [
                  Positioned(
                    bottom:
                        5, // Increase this value to add space between text and underline
                    child: Container(
                      width:
                          160, // Adjust width as per the text length or set it dynamically
                      height: 2.0, // Thickness of the underline
                      color: muvi_colorPrimary, // Underline color
                    ),
                  ),
                  Text(
                    "Active Match Up",
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
            Center(child: loadingWidgetMaker().visible(isLoading)),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: ListView.builder(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemCount: matches.length,
              itemBuilder: (context, index) {
                final matchup = matches[index];
                return MatchupCard(matchup: matchup);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class MatchupCard extends StatefulWidget {
  var matchup;

  MatchupCard({required this.matchup});

  @override
  State<MatchupCard> createState() => _MatchupCardState();
}

class _MatchupCardState extends State<MatchupCard> {
  getRandom() {
    Random random = Random();

    // Generate a random number between 0 and 2 (inclusive)
    int randomNumber = random.nextInt(4);
    return randomNumber;
  }

  var ImagesList =[
    "https://www.shutterstock.com/shutterstock/videos/3480597989/thumb/12.jpg?ip=x480",
    "https://as2.ftcdn.net/v2/jpg/02/76/09/45/500_F_276094500_uLvhdc025abo5dV1hzKAq4zmL3N2ECNz.jpg",
    "https://t4.ftcdn.net/jpg/03/23/27/39/360_F_323273934_LvPmP1epG8uJMgpZKJTGQeQ16OIDEbTQ.jpg",
    "https://t4.ftcdn.net/jpg/02/56/64/01/360_F_256640121_eMHCNxiKLfbZI2eSbV8afJQgfsHXQogv.jpg"
  ];

  void showPlayerDialog(BuildContext context,data) async {
    final playerData = data;
    final team1Players = playerData['team1'] ?? [];
    final team2Players = playerData['team2'] ?? [];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Teams Players'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Table(
                    border: TableBorder.all(
                      color: Colors.orange,
                    ),
                    columnWidths:const {
                      0:  FixedColumnWidth(100), // Team 1 column width
                      1: FixedColumnWidth(100), // Team 2 column width
                    },
                    children: [
                      TableRow(
                        children: [
                          Center(child: Text('Team 1', style: TextStyle(fontWeight: FontWeight.bold))),
                          Center(child: Text('Team 2', style: TextStyle(fontWeight: FontWeight.bold))),
                        ],
                      ),
                      // Use the maximum length of the two teams
                      for (int i = 0; i < (team1Players.length > team2Players.length ? team1Players.length : team2Players.length); i++)
                        TableRow(
                          children: [
                            Center(child: Text(i < team1Players.length ? team1Players[i]["name"] : '')),
                            Center(child: Text(i < team2Players.length ? team2Players[i]["name"] : '')),
                          ],
                        ),
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(playerData["matchDetails"],   style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),),
                    ),
                  ],
                )
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[900],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 5,
      margin: EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Section
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
            child: Image.network(
            ImagesList[getRandom()],
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Team Names
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${widget.matchup["team1Name"]}",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "vs",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFFE901C),
                      ),
                    ),
                    Text(
                      "${widget.matchup["team2Name"]}",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                // Matchup Summary
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.matchup["team1Score"].toString(),
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[400],
                      ),
                    ),
                    Text(
                      widget.matchup["team2Score"].toString(),
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // View Details Button
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0, bottom: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  showPlayerDialog(context,  widget.matchup);
                  // Action for "View Details"
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFE901C),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  "View Details",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
