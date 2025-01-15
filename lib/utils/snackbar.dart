import 'package:fantasyapp/utils/resources/flix_colors.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

void showSnackBar(String title, String message, bool isError,context) {
  final snackBar = SnackBar(
    backgroundColor: appBackgroundColorDark, // White background
    behavior: SnackBarBehavior.floating, // Makes the snackbar float
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12), // Rounded corners
    ),
    content: Container(
      color: appBackgroundColorDark,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon based on error or success
          Icon(
            isError ? Icons.error : Icons.check_circle,
            color: isError ? Colors.red : Colors.green,
            size: 24,
          ),
          const SizedBox(width: 12), // Space between icon and text
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title with bold text
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4), // Space between title and message
                // Message with gray text
                Text(
                  message,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    duration: const Duration(seconds: 2 ), // Duration to display the snackbar
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
