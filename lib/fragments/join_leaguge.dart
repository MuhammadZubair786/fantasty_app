// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, unused_field

import 'package:flutter/material.dart';

class JoinLeaguesPage extends StatelessWidget {
 final List<Map<String, String>> wrestlingLeagues = [
  {
    "name": "WWE Raw",
    "description": "World Wrestling Entertainment's flagship show.",
    "image":
        "https://media.tenor.com/maS2svZnO7wAAAAM/monday-night-raw-wwe.gif"
  },
  {
    "name": "WWE SmackDown",
    "description": "WWE's blue brand delivering prime action.",
    "image":
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSoOiRB0LdMEfpw1VXa2686NqIss_QHUBlmnA&s"
  },
  {
    "name": "AEW Dynamite",
    "description": "All Elite Wrestling's premier weekly event.",
    "image":
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS5c4ZyWc79D3Y3I9HLv27SqVVhj8ETy0QMipPP89DNiI5mZdonvzwH6qgEHNs_g2yB2o4&usqp=CAU"
  },
  {
    "name": "Impact Wrestling",
    "description": "Top stars and rivalries in Impact Wrestling.",
    "image":
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTbkk7PGaaD3bzoNu5xG3l_DL7WofVxJX-ZDg&s"
  },
  {
    "name": "NJPW Wrestle Kingdom",
    "description": "New Japan Pro Wrestling's iconic event.",
    "image":
        "https://upload.wikimedia.org/wikipedia/en/2/20/Wrestle_Kingdom_17_in_Tokyo_Dome_poster.jpg"
  },
  {
    "name": "NXT",
    "description": "WWE's developmental brand with emerging stars.",
    "image":
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTRdu0gkBVX-S4lDVZWKlyUK7HgECWSgWp-XA&s"
  },
  {
    "name": "Ring of Honor",
    "description": "Honor and intensity in professional wrestling.",
    "image":
        "https://i.ytimg.com/vi/5hMCdQjmTks/maxresdefault.jpg"
  },
  {
    "name": "Lucha Underground",
    "description": "High-flying action from Mexico's best.",
    "image":
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT-AOzPi38h9hr-LcdgjISQFNusZKxgQi3hqg&s"
  },
  {
    "name": "CMLL",
    "description": "The Consejo Mundial de Lucha Libre's iconic battles.",
    "image":
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRqLW_gvUEScjEwVL3Pzg0apXyyRplRvhb3xQ&s"
  },
  {
    "name": "AAA",
    "description": "Lucha Libre AAA Worldwide featuring top stars.",
    "image":
        "https://cdn.vox-cdn.com/thumbor/sFt3PrVUZJfqtNvldgf0zzAkLDY=/0x166:1080x706/fit-in/1200x600/cdn.vox-cdn.com/uploads/chorus_asset/file/23044609/FFIpN8GXMAQwsME.jpg"
  },
];


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.48,
          crossAxisSpacing: 19,
          mainAxisSpacing: 16,
        ),
        itemCount: wrestlingLeagues.length,
        itemBuilder: (context, index) {
          final league = wrestlingLeagues[index];
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
