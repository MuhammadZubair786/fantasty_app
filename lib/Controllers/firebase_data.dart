import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
        .collection('matches') // assuming the standings have a "rank" field
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

  Future<dynamic> getCurrentTimer() async {


  }

  Future<dynamic> getCurrentDraft() async {
    QuerySnapshot snapshot = await _firestore
        .collection('drafts') // Firestore collection
        .orderBy('startTime',
            descending: true) // Sort by startTime to get the latest
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
      return []; // Return a fallback message
    }
  }

  updateMemberScore(String draftId, String memberId, int index,
    int scoreIncrement, String state) async {
  try {
    // Reference to the draft document
    DocumentReference draftRef =
        FirebaseFirestore.instance.collection('drafts').doc(draftId);

    

    // Retrieve the current draft document snapshot
    DocumentSnapshot draftSnapshot = await draftRef.get();


    if (draftSnapshot.exists) {
      if(draftSnapshot["isActive"]==false){
        return false;
      }
      // Get the current members list
      List<dynamic> members = draftSnapshot['members'];
        for(var i=0;i<members.length;i++){
          if(memberId==members[i]["id"]){
            index = i; 
            break;
          }
        
        }
      if (index >= 0 && index < members.length) {
        if (state == "inc") {
          members[index]['score'] =
              (int.parse(members[index]['score'].toString()) + scoreIncrement).toString();
        } else if (state == "dec") {
          members[index]['score'] =
              (int.parse(members[index]['score'].toString()) - scoreIncrement).toString();
        }

        print(draftSnapshot['members'][index]["score"].toString());

        final prefs = await SharedPreferences.getInstance();
        var email = prefs.getString("user_email");

        if (members[index]["vote"] == null || members[index]["vote"] is! List) {
          members[index]["vote"] = [];
        }

       
        final existingVoteIndex = members[index]["vote"]
            .indexWhere((vote) => vote["email"] == email);

        if (existingVoteIndex != -1) {
          // Remove the email object if it exists
          members[index]["vote"].removeAt(existingVoteIndex);
          print("Email removed from the vote array.");
        } else {
          // Add the email object if it doesn't exist
          members[index]["vote"].add({"email": email});
          print("Email added to the vote array.");
        }
       

        // Update the members array in Firestore
        await draftRef.update({'members': members});
        print('Member score updated successfully with email added to vote.');
      } else {
        print('Invalid index.');
      }
    } else {
      print('Draft document not found.');
    }
    return true;
  } catch (e) {
    print('Error updating member score: $e');
  }
}

Future<List<Map<String, dynamic>>> getTermAndCondition() async {
    try {
      // Fetch all documents from the 'leagues' collection
      QuerySnapshot snapshot = await _firestore.collection('content').get();

      // Convert each document to a Map and return as a list
      List<Map<String, dynamic>> content = snapshot.docs
          .map((doc) => {
                "id": doc.id, // Add document ID if needed
                ...doc.data() as Map<String, dynamic>,
              })
          .toList();

      return content;
    } catch (e) {
      print("Error fetching leagues: $e");
      throw Exception("Failed to fetch leagues");
    }
  }




}
