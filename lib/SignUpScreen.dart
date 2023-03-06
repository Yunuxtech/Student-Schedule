import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';

import 'Component.dart';
import 'Toast.dart';
import 'homescreen.dart';
import 'package:flutter/material.dart';

import 'loginscreen.dart';

class signUpScreen extends StatefulWidget {
  const signUpScreen({super.key});

  @override
  State<signUpScreen> createState() => _signUpScreenState();
}

class _signUpScreenState extends State<signUpScreen> {
  @override
  Widget build(BuildContext context) {
    late String _email;
    late String _password;
    late String _regno;
    late String _fullname;
    final _formkey = GlobalKey<FormState>();
    bool isChecked = true;

// add form
    Widget _buildemail() {
      return SingleChildScrollView(
        child: TextFormField(
          decoration: InputDecoration(
              labelText: "Email",
              hintText: "youremail@gmail.com",
              fillColor: Colors.red),
          style: TextStyle(
            fontSize: 12,
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please Enter your Email Address';
            }
            return null;
          },
          onSaved: (value) {
            _email = value!;
          },
        ),
      );
    }

    Widget _buildName() {
      return SingleChildScrollView(
        child: TextFormField(
          decoration: InputDecoration(
              labelText: "FullName",
              hintText: "Isah Yunus",
              fillColor: Colors.red),
          style: TextStyle(
            fontSize: 12,
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please Enter your Fullname';
            }
            return null;
          },
          onSaved: (value) {
            _fullname = value!;
          },
        ),
      );
    }

    Widget _buildPassword() {
      return SingleChildScrollView(
        child: TextFormField(
          obscureText: false,
          decoration:
              InputDecoration(labelText: "Password", hintText: "********"),
          style: TextStyle(fontSize: 12),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please Enter your Password';
            }
            return null;
          },
          onSaved: (value) {
            _password = value!;
          },
        ),
      );
    }

    Widget _buildRegNo() {
      return SingleChildScrollView(
        child: TextFormField(
          decoration: InputDecoration(
              labelText: "Registraion No.", hintText: "CST/17/IFT/...."),
          style: TextStyle(fontSize: 12),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please Enter your Reg.No';
            }
            return null;
          },
          onSaved: (value) {
            _regno = value!;
          },
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 4,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 72, 158, 228),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text(
                    "Student App",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: SingleChildScrollView(
                    child: Container(
                      width: MediaQuery.of(context).size.height * 0.4,
                      height: MediaQuery.of(context).size.height * 0.7,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 2,
                              offset: Offset(0, 3),
                            ),
                          ]),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "SIGN UP",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 72, 158, 228),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                            

                            Form(
                              key: _formkey,
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    _buildName(),
                                    _buildRegNo(),
                                    _buildemail(),
                                    _buildPassword(),
                                    SizedBox(
                                      height: 10,
                                    ),
                                  ]),
                            ),

                            SizedBox(
                              height: 10,
                            ),

                            //  added button
                           Container(
                                height: 40,
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                width: 200,
                                child: ElevatedButton(
                                  autofocus: false,
                                  onPressed: () {
                                    if (_formkey.currentState!.validate()) {
                                      _formkey.currentState!.save();
                                      toastmessage(
                                          "Sign Up Successfully, Proceed to Login");
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  signUpScreen()));
                                    }
                                  },
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    backgroundColor: MaterialStateProperty.all(
                                      Color.fromARGB(255, 84, 169, 219),
                                    ),
                                  ),
                                  child: Text(
                                    "SIGN UP",
                                  ),
                                ),
                              ),
                            

                            // roundbutton(
                            //     title: "Sign Up",
                            //     tapfun: () {
                            //       if (_formkey.currentState!.validate()) {
                            //         toastmessage(
                            //             "Registration Sucessful, proceed to Login");
                            //       }

                            //       // });
                            //     }),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        toastmessage("Please Login");
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => loginscreen()));
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(
                          color: Color.fromARGB(255, 72, 158, 228),
                        ),
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
