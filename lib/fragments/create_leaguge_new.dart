import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fantasyapp/utils/flix_app_widgets.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class CreateLeaguePage extends StatefulWidget {
  @override
  State<CreateLeaguePage> createState() => _CreateLeaguePageState();
}

class _CreateLeaguePageState extends State<CreateLeaguePage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _leagueNameController = TextEditingController();

  final TextEditingController _descriptionController = TextEditingController();

  String? _leagueType;

    bool isLoading = false;

  // Firestore instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

   showLoading(bool show) {
    setState(
      () {
        isLoading = show;
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            const SizedBox(height: 20),
            // League Name
            const Text(
              "League Name",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            SizedBox(height: 8),
            TextFormField(
              controller: _leagueNameController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Enter league name",
                hintStyle: TextStyle(color: Colors.grey[600]),
                filled: true,
                fillColor: Colors.grey[900],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: Colors.grey[700]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: Color(0xFFFE901C), width: 2),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a league name';
                }
                return null;
              },
            ),
            SizedBox(height: 20),

            // Description
            Text(
              "Description",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            SizedBox(height: 8),
            TextFormField(
              controller: _descriptionController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Enter league description",
                hintStyle: TextStyle(color: Colors.grey[600]),
                filled: true,
                fillColor: Colors.grey[900],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: Colors.grey[700]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: Color(0xFFFE901C), width: 2),
                ),
              ),
              maxLines: 3,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a description';
                }
                return null;
              },
            ),
            SizedBox(height: 20),

            // League Type
            Text(
              "League Type",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            SizedBox(height: 8),
            DropdownButtonFormField<String>(
              style: TextStyle(color: Colors.white),
              dropdownColor: Colors.grey[900],
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[900],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: Colors.grey[700]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: Color(0xFFFE901C), width: 2),
                ),
              ),
              items: const [
                DropdownMenuItem(
                  value: "Public",
                  child: Text("Public", style: TextStyle(color: Colors.white)),
                ),
                DropdownMenuItem(
                  value: "Private",
                  child: Text("Private", style: TextStyle(color: Colors.white)),
                ),
              ],
              onChanged: (value) {
                _leagueType = value;
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select a league type';
                }
                return null;
              },
            ),
            SizedBox(height: 20),

            // Create League Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState?.validate() == true) {
                    // Submit form and save data to Firestore
                    try {
                      showLoading(true);
                      await _firestore.collection('leagues').add({
                        'name': _leagueNameController.text,
                        'description': _descriptionController.text,
                        'leagueType': _leagueType,
                        'createdAt': FieldValue.serverTimestamp(),
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('League created successfully!')),
                      );
                      showLoading(false);

                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error creating league: $e')),
                      );
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFE901C),
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: Text(
                  "Create League",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            loadingWidgetMaker().visible(isLoading)
          ],
        ),
      ),
    );
  }
}
