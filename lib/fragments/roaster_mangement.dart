import 'package:cloud_firestore/cloud_firestore.dart';
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
  var activeRoster = [];
  var benchRoster = [];
  // void _moveToBench(Map<String, dynamic> wrestler) {
  //   setState(() {
  //     activeRoster.remove(wrestler);
  //     benchRoster.add(wrestler);
  //   });
  // }

  // void _moveToActive(Map<String, dynamic> wrestler) {
  //   setState(() {
  //     benchRoster.remove(wrestler);
  //     activeRoster.add(wrestler);
  //   });
  // }

 @override
  void initState(){
    super.initState();
    fetchRosters();
  }
  var loading =false;

  Future<void> fetchRosters() async {
    try {
      setState(() {
        loading=true;
      });
      final activeSnapshot =
          await FirebaseFirestore.instance.collection('wrestlers').where('status', isEqualTo: 'Active').get();
      final benchSnapshot =
          await FirebaseFirestore.instance.collection('wrestlers').where('status', isNotEqualTo: 'Active').get();

      setState(() {
        activeRoster = activeSnapshot.docs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .toList();
        benchRoster = benchSnapshot.docs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .toList();
      });
      print(activeRoster);
       setState(() {
        loading=false;
      });
    } catch (e) {
      print("Error fetching data: $e");
       setState(() {
        loading=false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: Icon(Icons.arrow_back,color: Colors.white,),
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Roster Managements",
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
                        const Text(
                          "Active Roster",
                          style: TextStyle(
                            color: Color(0xFFFE901C),
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Divider(color: Colors.white),
                        loading ? Container(
                      height: 300,
                      child: Center(
                          child: CircularProgressIndicator(
                        color: Colors.white,
                      ))):
                        Expanded(
                          child: ListView.builder(
                            itemCount: activeRoster.length,
                            itemBuilder: (context, index) {
                              final wrestler = activeRoster[index];
                              return GestureDetector(
                                child: Card(
                                  color: Colors.grey[850],
                                  margin: EdgeInsets.symmetric(vertical: 10),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              wrestler['name'],
                                              style: const TextStyle(
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
                        const Text(
                          "Bench Roster",
                          style: TextStyle(
                            color: Color(0xFFFE901C),
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Divider(color: Colors.white),
                          loading ? Container(
                      height: 300,
                      child: Center(
                          child: CircularProgressIndicator(
                        color: Colors.white,
                      ))):
                        Expanded(
                          child: ListView.builder(
                            itemCount: benchRoster.length,
                            itemBuilder: (context, index) {
                              final wrestler = benchRoster[index];
                              return GestureDetector(
                                child: Card(
                                  color: Colors.grey[850],
                                  margin: EdgeInsets.symmetric(vertical: 10),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              wrestler['name'],
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              "Rank: ${wrestler['rank']}",
                                              style: TextStyle(
                                                color: Colors.grey[400],
                                              ),
                                            ),
                                            const SizedBox(height: 8),
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
