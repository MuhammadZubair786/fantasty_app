import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: RosterManagementScreen(),
  ));
}

class RosterManagementScreen extends StatefulWidget {
  @override
  _RosterManagementScreenState createState() => _RosterManagementScreenState();
}

class _RosterManagementScreenState extends State<RosterManagementScreen> {
  final List<Map<String, dynamic>> activeRoster = [
    {
      "name": "John Cena",
      "wins": 10,
      "losses": 2,
      "rank": 1,
      "points": 120,
      "image": "https://media.tenor.com/zdO3lzqAQ4QAAAAM/john-cena-entrance.gif",
      "isDrafted": false,
    },
    {
      "name": "The Rock",
      "wins": 8,
      "losses": 4,
      "rank": 2,
      "points": 110,
      "image": "https://media.tenor.com/tIipABYYssMAAAAM/the-rock-entrance.gif",
      "isDrafted": false,
    },
    {
      "name": "Roman Reigns",
      "wins": 11,
      "losses": 1,
      "rank": 3,
      "points": 125,
      "image": "https://media.tenor.com/9thnUHjMC4QAAAAM/roman-reigns-one.gif",
      "isDrafted": false,
    },
    {
      "name": "Brock Lesnar",
      "wins": 9,
      "losses": 3,
      "rank": 4,
      "points": 115,
      "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQhT9VLVsDex9CsRfhpdA4L5sfhmnZfP_pG9w&s",
      "isDrafted": false,
    },
    {
      "name": "Seth Rollins",
      "wins": 7,
      "losses": 5,
      "rank": 5,
      "points": 100,
      "image": "https://i.pinimg.com/originals/55/68/59/556859b5353981ab02613c24063cb0e0.gif",
      "isDrafted": false,
    },
  ];

  final List<Map<String, dynamic>> benchRoster = [
    {
      "name": "AJ Styles",
      "wins": 6,
      "losses": 6,
      "rank": 6,
      "points": 95,
      "image": "https://img.wattpad.com/9c93bf436a3fcd9dd829f9d1f849b8ee332c0a35/68747470733a2f2f73332e616d617a6f6f7770732e636f6d2f776174747061642d6d656469612d736572766963652f53746f7279496d6167652f6f766e6c376e78357470783174413d3d2d3432303731313039332e313463343766363165656562333763343136383236363737383336372e676966",
      "isDrafted": false,
    },
    {
      "name": "Edge",
      "wins": 12,
      "losses": 0,
      "rank": 7,
      "points": 130,
      "image": "https://media.tenor.com/FFx9YWNEvLkAAAAM/edge-entrance.gif",
      "isDrafted": false,
    },
    {
      "name": "Kofi Kingston",
      "wins": 5,
      "losses": 7,
      "rank": 8,
      "points": 90,
      "image": "https://media.tenor.com/Zi9F-1D5sO4AAAAM/the-new-day-kofi-kingston.gif",
      "isDrafted": false,
    },
    {
      "name": "Finn Balor",
      "wins": 9,
      "losses": 4,
      "rank": 9,
      "points": 105,
      "image": "https://media.tenor.com/5tkYZ03S7LIAAAAM/finn-balor.gif",
      "isDrafted": false,
    },
    {
      "name": "Randy Orton",
      "wins": 10,
      "losses": 5,
      "rank": 10,
      "points": 110,
      "image": "https://i.pinimg.com/originals/57/65/40/5765401589e54123f477ba2816a421af.gif",
      "isDrafted": false,
    },
  ];

  void _moveToBench(Map<String, dynamic> wrestler) {
    setState(() {
      activeRoster.remove(wrestler);
      benchRoster.add(wrestler);
    });
  }

  void _moveToActive(Map<String, dynamic> wrestler) {
    setState(() {
      benchRoster.remove(wrestler);
      activeRoster.add(wrestler);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Roster Management",
          style: TextStyle(
            color: Color(0xFFFE901C),
            fontSize: 22,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Active Roster Section
            Expanded(
              child: Row(
                children: [
                  // Active Roster Column
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Active Roster",
                          style: TextStyle(
                            color: Color(0xFFFE901C),
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Divider(color: Colors.white),
                        Expanded(
                          child: ListView.builder(
                            itemCount: activeRoster.length,
                            itemBuilder: (context, index) {
                              final wrestler = activeRoster[index];
                              return GestureDetector(
                                onTap: () => _moveToBench(wrestler),
                                child: Card(
                                  color: Colors.grey[850],
                                  margin: EdgeInsets.symmetric(vertical: 10),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Image.network(
                                          wrestler['image'],
                                          height: 150,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              wrestler['name'],
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(height: 8),
                                            Text(
                                              "Rank: ${wrestler['rank']}",
                                              style: TextStyle(
                                                color: Colors.grey[400],
                                              ),
                                            ),
                                            SizedBox(height: 8),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.arrow_forward,
                                                  color: Colors.orange,
                                                ),
                                                SizedBox(width: 4),
                                                Text(
                                                  "Move to Bench",
                                                  style: TextStyle(
                                                    color: Colors.orange,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 20),
                  // Bench Roster Column
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Bench Roster",
                          style: TextStyle(
                            color: Color(0xFFFE901C),
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Divider(color: Colors.white),
                        Expanded(
                          child: ListView.builder(
                            itemCount: benchRoster.length,
                            itemBuilder: (context, index) {
                              final wrestler = benchRoster[index];
                              return GestureDetector(
                                onTap: () => _moveToActive(wrestler),
                                child: Card(
                                  color: Colors.grey[850],
                                  margin: EdgeInsets.symmetric(vertical: 10),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Image.network(
                                          wrestler['image'],
                                          height: 150,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              wrestler['name'],
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(height: 8),
                                            Text(
                                              "Rank: ${wrestler['rank']}",
                                              style: TextStyle(
                                                color: Colors.grey[400],
                                              ),
                                            ),
                                            SizedBox(height: 8),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.arrow_back,
                                                  color: Colors.orange,
                                                ),
                                                SizedBox(width: 4),
                                                Text(
                                                  "Move to Active",
                                                  style: TextStyle(
                                                    color: Colors.orange,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
