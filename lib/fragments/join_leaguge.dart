// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, unused_field

import 'package:flutter/material.dart';

class JoinLeaguesPage extends StatelessWidget {
  final List<Map<String, String>> leagues = [
    {
      "name": "Premier League",
      "description": "England's Top Clubs",
      "image":
          "https://e0.365dm.com/24/07/2048x1152/skysports-premier-league-season_6629191.jpg?20241210105711"
    },
    {
      "name": "La Liga",
      "description": "Spanish Champions Battle",
      "image":
          "https://img.jakpost.net/c/2019/05/16/2019_05_16_72382_1557949331._large.jpg"
    },
    {
      "name": "Serie A",
      "description": "Italy's Best Teams Compete",
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRJJjMwuE3_cv54RZAovzpyCJ70yIynYzAbRA&s"
    },
    {
      "name": "Bundesliga",
      "description": "German Elite Football",
      "image":
          "https://media.dfl.de/sites/3/2018/02/BL_Teaser_BL-Logo_Pitch_HD.jpg"
    },
    {
      "name": "MLS",
      "description": "Top US Soccer League",
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRGbpuGD6NbeH6iejnRjtSoF3dzq4yVPOzVbg&s"
    },
    {
      "name": "Ligue 1",
      "description": "French Football Action",
      "image":
          "https://1000logos.net/wp-content/uploads/2019/01/French-Ligue-1-Logo-2020-1.png"
    },
    {
      "name": "Eredivisie",
      "description": "Dutch Football League",
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRqUpda9WZY1XI99HfJGWMxrEDsn-aiWeeXsg&s"
    },
    {
      "name": "Super Lig",
      "description": "Turkey's Football Stars",
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ99Jz9eh5zMBQpPqdWvSwzP0wxyY-q-1owMQ&s"
    },
    {
      "name": "Championship",
      "description": "UK Second Division Action",
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcThUii0K7mAMEeeRTYdi20M_mnX_c-0xO9fMg&s"
    },
    {
      "name": "J-League",
      "description": "Japan's Elite League",
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSmv8b9vY-eho8vMf-WPxqcZ67XDQYc4NSyeA&s"
    },
  ];



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.58,
          crossAxisSpacing: 19,
          mainAxisSpacing: 16,
        ),
        itemCount: leagues.length,
        itemBuilder: (context, index) {
          final league = leagues[index];
          return GestureDetector(
            onTap: () {
              // Navigate to Details Page
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => LeagueDetailsPage(league: league)),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0, 4),
                    blurRadius: 6,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16)),
                    child: Image.network(
                      league['image']!,
                      height: 120,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      league['name']!,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      league['description']!,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[400],
                      ),
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFFE901C),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                        onPressed: () {
                          // Navigate to Details Page
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    LeagueDetailsPage(league: league)),
                          );
                        },
                        child: Text(
                          "Join",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// League Details Page
class LeagueDetailsPage extends StatelessWidget {
  final Map<String, String> league;

  const LeagueDetailsPage({Key? key, required this.league}) : super(key: key);

  
   void _showJoinDialog(BuildContext context, String leagueName) {
    showDialog(
      context: context,
      builder: (context) {
        return JoinLeagueForm(leagueName: leagueName);
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          league["name"]!,
          style:
              TextStyle(color: Color(0xFFFE901C), fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Color(0xFFFE901C)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  league['image']!,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              league['name']!,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              league['description']!,
              style: TextStyle(fontSize: 16, color: Colors.grey[400]),
            ),
            Divider(color: Colors.grey[700]),
            SizedBox(height: 8),
            Text(
              "League Highlights",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFE901C)),
            ),
            SizedBox(height: 8),
            Text(
              "🔸 Top teams competing for the title.\n🔸 Exciting match schedules.\n🔸 Over 20 matches this season.\n🔸 Watch live or join the community!",
              style: TextStyle(fontSize: 14, color: Colors.grey[400]),
            ),
            Spacer(),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFFE901C),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              ),
              onPressed: () {
              _showJoinDialog(context, league['name']!);
              },
              child: Text(
                "Join League",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// Join League Form Dialog
class JoinLeagueForm extends StatefulWidget {
  final String leagueName;

  const JoinLeagueForm({Key? key, required this.leagueName}) : super(key: key);

  @override
  State<JoinLeagueForm> createState() => _JoinLeagueFormState();
}

class _JoinLeagueFormState extends State<JoinLeagueForm> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _email = '';

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      backgroundColor: Colors.grey[900],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Join ${widget.leagueName}",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            SizedBox(height: 10),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: "Name",
                      labelStyle: TextStyle(color: Colors.grey[400]),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFFE901C)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    validator: (value) => value!.isEmpty ? "Enter your name" : null,
                    onSaved: (value) => _name = value!,
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: "Email",
                      labelStyle: TextStyle(color: Colors.grey[400]),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFFE901C)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    validator: (value) => !value!.contains("@") ? "Enter a valid email" : null,
                    onSaved: (value) => _email = value!,
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFE901C),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Successfully joined ${widget.leagueName}!")),
                    );
                  }
                },
                child: Text(
                  "Join Now",
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
