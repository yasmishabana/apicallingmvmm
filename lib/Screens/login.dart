import 'dart:developer';
import 'package:apicallingmvmm/Provider/commonviewmodel.dart';
import 'package:apicallingmvmm/Screens/home.dart';
import 'package:apicallingmvmm/Screens/welcome.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'Register/reg.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Create text editing controllers
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? username, password;
  CommonViewModel? vm;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "asset/image/login.jpg",
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 220),
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height -
                  220, // Set height dynamically
              decoration: const BoxDecoration(
                color: Colors.white, // White background for the container
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(90),
                ), // Rounded corners at the top-left
              ),
              child: SingleChildScrollView(
                // Add scrollable view
                padding: const EdgeInsets.all(24.0),
                child: Form(
                  key: _formKey, // Form key for validation
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(child: Welcome()),
                      const SizedBox(height: 30),
                      // Username field
                      TextFormField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                          labelText: 'Username',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your username';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      // Password field
                      TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 40),
                      // Login button
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              vm = Provider.of<CommonViewModel>(context,
                                  listen: false);

                              // Use the .text property to get the input values
                              vm!
                                  .login(_usernameController.text,
                                      _passwordController.text)
                                  .then((value) {
                                if (vm!.response!.msg == "success") {
                                  log("loginsuccess");
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return HomePage();
                                  }));
                                } else {
                                  log("login failed");
                                }
                              });
                            }

                            // if (_formKey.currentState!.validate()) {
                            //   vm = Provider.of<CommonViewModel>(context,
                            //       listen: false);
                            //   vm!
                            //       .login(_usernameController.text(),
                            //           _passwordController)
                            //       .then((value) {
                            //     if (vm!.response!.msg == "success") {
                            //       log("loginsuccess");
                            //       Navigator.push(context,
                            //           MaterialPageRoute(builder: (context) {
                            //         return HomePage();
                            //       }));
                            //     } else {
                            //       log("login failed");
                            //     }
                            //   });
                            // }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black, // Set button color to black
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'Login',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Register text
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    RegisterPage(), // Replace with your RegisterPage widget
                              ),
                            );
                          },
                          child: RichText(
                            text: const TextSpan(
                              text: "Don't have an account? ",
                              style: TextStyle(color: Colors.black),
                              children: [
                                TextSpan(
                                  text: 'Go to Register',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
