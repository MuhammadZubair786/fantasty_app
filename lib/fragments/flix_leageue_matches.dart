import 'package:fantasyapp/utils/flix_constants.dart';
import 'package:fantasyapp/utils/resources/flix_colors.dart';
import 'package:fantasyapp/utils/resources/flix_size.dart';
import 'package:flutter/material.dart';

class Matchup {
  final String team1;
  final String team2;
  final String summary;
  final String imageUrl;

  Matchup({
    required this.team1,
    required this.team2,
    required this.summary,
    required this.imageUrl,
  });
}

List<Matchup> matchups = [
  Matchup(
    team1: "Lions",
    team2: "Tigers",
    summary: "A fierce battle between two rivals!",
    imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSeQcn7Sxo1TkPgcGGPs60e33ux-ewe5vtUOg&s",
  ),
  Matchup(
    team1: "Sharks",
    team2: "Eagles",
    summary: "Eagles are leading the game with a narrow margin.",
    imageUrl: "https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/e6025648-55c5-4a75-9b23-3f8924e5ac00/dyjrqd-3d4179cc-3ce5-44fa-acd9-c22d4e80539b.png?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7InBhdGgiOiJcL2ZcL2U2MDI1NjQ4LTU1YzUtNGE3NS05YjIzLTNmODkyNGU1YWMwMFwvZHlqcnFkLTNkNDE3OWNjLTNjZTUtNDRmYS1hY2Q5LWMyMmQ0ZTgwNTM5Yi5wbmcifV1dLCJhdWQiOlsidXJuOnNlcnZpY2U6ZmlsZS5kb3dubG9hZCJdfQ.ZZR4G7bsraLJnohj91YvQeGmlXeemzleAk6IP4N1Tik",
  ),
  Matchup(
    team1: "Warriors",
    team2: "Panthers",
    summary: "Panthers making a surprising comeback!",
    imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSsRN7S-F9bJVQt6yozd0yg1Zpt8e1j0JiAYg&s",
  ),
];

class ActiveMatchupsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
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
                    bottom: 5, // Increase this value to add space between text and underline
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
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: ListView.builder(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemCount: matchups.length,
                itemBuilder: (context, index) {
                  final matchup = matchups[index];
                  return MatchupCard(matchup: matchup);
                },
              ),
           
          ),
        ],
      ),
    );
  }
}

class MatchupCard extends StatelessWidget {
  final Matchup matchup;

  MatchupCard({required this.matchup});

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
              matchup.imageUrl,
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
                      "${matchup.team1}",
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
                      "${matchup.team2}",
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
                Text(
                  matchup.summary,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[400],
                  ),
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


