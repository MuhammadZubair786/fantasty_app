import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SearchFragment(),
  ));
}

class SearchFragment extends StatefulWidget {
  @override
  _SearchFragmentState createState() => _SearchFragmentState();
}

class _SearchFragmentState extends State<SearchFragment> {
final List<Map<String, dynamic>> wrestlers = [
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
    {
      "name": "AJ Styles",
      "wins": 6,
      "losses": 6,
      "rank": 6,
      "points": 95,
      "image": "https://img.wattpad.com/9c93bf436a3fcd9dd829f9d1f849b8ee332c0a35/68747470733a2f2f73332e616d617a6f6e6177732e636f6d2f776174747061642d6d656469612d736572766963652f53746f7279496d6167652f6f766e6c376e78357470783174413d3d2d3432303731313039332e313463343766363165656562333763343136383236363737383336372e676966",
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

  Timer? _timer;
  int _remainingTime = 60;

  @override
  void initState() {
    super.initState();
    _startDraftTimer();
  }

  void _startDraftTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        setState(() {
          _remainingTime--;
        });
      } else {
        _timer?.cancel();
      }
    });
  }

  void _draftWrestler(int index) {
    setState(() {
      wrestlers[index]['isDrafted'] = true;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("${wrestlers[index]['name']} has been drafted!"),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
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
          "Draft Screen",
          style: TextStyle(
            color: Color(0xFFFE901C),
            fontSize: 30,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.5,
          ),
        ),
      ),
      body: Column(
        children: [
          // Draft Timer Box with Gradient
          Container(
            margin: EdgeInsets.all(16),
            padding: EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFFE901C), Colors.orangeAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.orange.withOpacity(0.6),
                  offset: Offset(0, 4),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Center(
              child: Text(
                "Time Remaining: ${_remainingTime}s",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          // Divider
          Divider(color: Colors.grey[800], thickness: 1),
          // Wrestler List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16),
              itemCount: wrestlers.length,
              itemBuilder: (context, index) {
                final wrestler = wrestlers[index];
                return GestureDetector(
                  onTap: () => _draftWrestler(index),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 15),
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.grey[850],
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black45,
                              offset: Offset(0, 4),
                              blurRadius: 12,
                            ),
                          ],
                          border: Border.all(
                            color: wrestler['isDrafted']
                                ? Colors.green
                                : Colors.transparent,
                            width: 3,
                          ),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                // Large Image
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.network(
                                    wrestler['image'],
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(width: 20),
                                // Wrestler Info
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        wrestler['name'],
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 6),
                                      Text(
                                        "Rank: ${wrestler['rank']} | Points: ${wrestler['points']}",
                                        style: TextStyle(
                                          color: Colors.grey[400],
                                          fontSize: 16,
                                        ),
                                      ),
                                      SizedBox(height: 6),
                                      Text(
                                        "Wins: ${wrestler['wins']} | Losses: ${wrestler['losses']}",
                                        style: TextStyle(
                                          color: Colors.grey[400],
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // Draft Button or Indicator
                               
                              ],
                            ), Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            wrestler['isDrafted']
                                ? Icon(
                                    Icons.check_circle,
                                    color: Colors.green,
                                    size: 32,
                                  )
                                : ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Color(0xFFFE901C),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 8),
                                    ),
                                    onPressed: () => _draftWrestler(index),
                                    child: Text(
                                      "Draft",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                          ],
                        ),
                      ),
                      
                    ],
                  ));  }))]      
      ),
    );
  }
}
