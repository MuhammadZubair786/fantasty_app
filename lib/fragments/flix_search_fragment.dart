// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';
import 'dart:developer';
import 'package:fantasyapp/Controllers/firebase_data.dart';
import 'package:fantasyapp/utils/flix_constants.dart';
import 'package:fantasyapp/utils/resources/flix_colors.dart';
import 'package:fantasyapp/utils/resources/flix_size.dart';
import 'package:flutter/material.dart';


class SearchFragment extends StatefulWidget {
  @override
  _SearchFragmentState createState() => _SearchFragmentState();
}

class _SearchFragmentState extends State<SearchFragment> {
   List wrestlers = [
  
    // Add more wrestlers as needed
  ];

  // void initState(){
  //   super.initState();
  //   getData();
  // }

  void _toggleDraftStatus(int index) {
    if(_remainingTime==0){
      ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Time Is Over"),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 2),
      ),
    );

    }
    else{
   setState(() {
      wrestlers[index]['isDrafted'] = !wrestlers[index]['isDrafted'];
    });
    }
 
  }

  Timer? _timer;
  int _remainingTime = 60;

  @override
  void initState() {
    super.initState();
    _startDraftTimer();
    getData();
  }
  

    getData() async {
    var listData =[];
    var res = await FirestoreService().getCurrentDraft();
    log(res.toString());
    listData.addAll(res);
    wrestlers = listData;
    for(var i=0;i<res[0]["members"].length;i++){
      filterData(res[0],res[0]["members"][i]);
    }
  
    
  }

  filterData(data,member ){
    print(member["vote"]);
    if(member["vote"]){

    }


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

  @override
  Widget build(BuildContext context) {
    final draftedWrestlers =
        wrestlers.where((wrestler) => wrestler['isDrafted']).toList();
    final availableWrestlers =
        wrestlers.where((wrestler) => !wrestler['isDrafted']).toList();

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
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
               Container(
            margin: EdgeInsets.all(12 ),
            padding: EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFFE901C), Colors.orangeAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: const Color.fromARGB(255, 246, 246, 246).withOpacity(0.6),
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
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          // Divider
          Divider(color: Colors.grey[800], thickness: 1),
              Container(
                height: MediaQuery.of(context).size.height*0.8,
                child: Row(
                  children: [
                    // Available Column
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildSectionTitle("Available"),
                          Expanded(
                            child: ListView.builder(
                              padding: EdgeInsets.all(16),
                              itemCount: availableWrestlers.length,
                              itemBuilder: (context, index) {
                                final wrestler = availableWrestlers[index];
                                return _buildWrestlerCard(
                                    wrestler, wrestlers.indexOf(wrestler), "Draft");
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    VerticalDivider(color: Colors.grey[800], thickness: 1),
                    // Drafted Column
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildSectionTitle("Drafted"),
                           
                          Expanded(
                            child: ListView.builder(
                              padding: EdgeInsets.all(16),
                              itemCount: draftedWrestlers.length,
                              itemBuilder: (context, index) {
                                final wrestler = draftedWrestlers[index];
                                return _buildWrestlerCard(
                                    wrestler, wrestlers.indexOf(wrestler), "Release");
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
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    var space = "        ";

    return 
    Padding(
                    padding: EdgeInsets.only(
                        left: 10.0, right: 20.0), // Extra space on the right
                    child: Stack(
                      children: [
                        Positioned(
                          bottom: 0, // Position underline closer to the text
                          child: Container(
                            width:
                                200, // Adjust width as per the text length or set it dynamically
                            height: 2.0, // Thickness of the underline
                            color: muvi_colorPrimary, // Underline color
                          ),
                        ),
                        Text(
                        space+title+space,
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
                  );
    
    
  }

  Widget _buildWrestlerCard(
      Map<String, dynamic> wrestler, int index, String buttonText) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.all(10),
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
          color: wrestler['isDrafted'] ? Colors.green : Colors.transparent,
          width: 3,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // ClipRRect(
          //                               borderRadius: BorderRadius.circular(12),
          //                               child: Image.network(
          //                                 wrestler['image'],
          //                                 height: 150,
          //                                 width: double.infinity,
          //                                 fit: BoxFit.cover,
          //                               ),
          //                             ),
          Text(
            wrestler['name'],
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "Rank: ${wrestler['rank']} | Points: ${wrestler['points']}",
            style: TextStyle(
              color: Colors.grey[400],
              fontSize: 10,
            ),
          ),
          SizedBox(height: 6),
          Text(
            "Wins: ${wrestler['wins']} | Losses: ${wrestler['losses']}",
            style: TextStyle(
              color: Colors.grey[400],
              fontSize: 10,
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFFE901C),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
            onPressed: () => _toggleDraftStatus(index),
            child: Text(
              buttonText,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
