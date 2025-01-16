import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> getAllLeagues() async {
    try {
      // Fetch all documents from the 'leagues' collection
      QuerySnapshot snapshot = await _firestore.collection('leagues').get();

      // Convert each document to a Map and return as a list
      List<Map<String, dynamic>> leagues = snapshot.docs
          .map((doc) => {
                "id": doc.id, // Add document ID if needed
                ...doc.data() as Map<String, dynamic>,
              })
          .toList();

      return leagues;
    } catch (e) {
      print("Error fetching leagues: $e");
      throw Exception("Failed to fetch leagues");
    }
  }

  Future<List<Map<String, dynamic>>> getAllTeams() async {
    try {
      // Fetch all documents from the 'leagues' collection
      QuerySnapshot snapshot = await _firestore.collection('teams').get();

      // Convert each document to a Map and return as a list
      List<Map<String, dynamic>> leagues = snapshot.docs
          .map((doc) => {
                "id": doc.id, // Add document ID if needed
                ...doc.data() as Map<String, dynamic>,
              })
          .toList();

      return leagues;
    } catch (e) {
      print("Error fetching teams: $e");
      throw Exception("Failed to fetch teams");
    }
  }

Future<List<Map<String, dynamic>>> getStandings() async {
    QuerySnapshot snapshot = await _firestore
        .collection('leaguesStanding')
        .orderBy('order') // assuming the standings have a "rank" field
        .get();

    // Map over the results and include an index starting from 0
    List<Map<String, dynamic>> standings = snapshot.docs
        .asMap() // This gives you the index along with the data
        .map((index, doc) {
          return MapEntry(index, {
            "rank": index, // Set the "rank" field as the index
            ...doc.data() as Map<String, dynamic>,
          });
        })
        .values
        .toList();

    return standings;
  }

  Future<List<Map<String, dynamic>>> getAllMatches() async {
    QuerySnapshot snapshot = await _firestore
        .collection('matches')// assuming the standings have a "rank" field
        .get();

    // Map over the results and include an index starting from 0
    List<Map<String, dynamic>> standings = snapshot.docs
        .asMap() // This gives you the index along with the data
        .map((index, doc) {
          return MapEntry(index, {
          
            ...doc.data() as Map<String, dynamic>,
          });
        })
        .values
        .toList();

    return standings;
  }


  Future<dynamic> getCurrentDraft() async {
  QuerySnapshot snapshot = await _firestore
      .collection('drafts') // Firestore collection
      .orderBy('startTime', descending: true) // Sort by startTime to get the latest
      .get();

  // Filter the documents where isActive is true
  List<Map<String, dynamic>> activeDrafts = snapshot.docs
      .map((doc) => doc.data() as Map<String, dynamic>)
      .where((data) => data['isActive'] == true)
      .toList();

  // Check if any drafts are active
  if (activeDrafts.isNotEmpty) {
    return activeDrafts; // Return the list of active drafts
  } else {
    return "No current draft"; // Return a fallback message
  }
}

}
