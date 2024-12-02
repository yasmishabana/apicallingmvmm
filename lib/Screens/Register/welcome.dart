import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Account extends StatelessWidget {
  const Account({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center, // Center horizontally
      children: [
        const SizedBox(height: 5), // Space at the top of the container
        const Text(
          'Register Account', // Fixed double quote
          style: TextStyle(
            fontSize: 28, // Font size
            fontWeight: FontWeight.bold, // Bold text
            color: Colors.black, // Text color
          ),
          textAlign: TextAlign.center, // Center the text
        ),
        // Space between text widgets
        const Text(
          "Complete your details \n", // Description text
          style: TextStyle(
            fontSize: 16, // Font size for the description
            color: Colors.black54, // Lighter text color
          ),
          textAlign: TextAlign.center, // Center the text
        ),
        // Add your TextFormFields and Button here
      ],
    );
  }
}
