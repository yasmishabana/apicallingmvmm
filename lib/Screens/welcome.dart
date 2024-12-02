import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Welcome extends StatelessWidget {
  const Welcome({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center, // Center horizontally
      children: [
        const SizedBox(height: 20), // Space at the top of the container
        const Text(
          'Welcome Back',
          style: TextStyle(
            fontSize: 28, // Font size
            fontWeight: FontWeight.bold, // Bold text
            color: Colors.black, // Text color
          ),
          textAlign: TextAlign.center, // Center the text
        ),
        Text("login with your username and password \n")
      ],
    );
  }
}
