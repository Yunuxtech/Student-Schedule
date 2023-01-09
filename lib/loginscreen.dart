import 'dart:html';
import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'Component.dart';

import 'package:flutter/material.dart';

import 'Forgetpassword.dart';
import 'Homescreen.dart';
import 'Loginwithphoneno.dart';
import 'SignUpScreen.dart';
import 'Toast.dart';
import 'drawer/drawer.dart';

class loginscreen extends StatefulWidget {
  const loginscreen({super.key});
  

  @override
  State<loginscreen> createState() => _loginscreenState();
}


class _loginscreenState extends State<loginscreen> {
  bool _obscureText = false;
  final _formkey = GlobalKey<FormState>();
  late String _email;
  late String _password;
  // late bool _obscureText;
 
// Form screen

  Widget _buildPassword() {
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(
          labelText: "Password",
          hintText: "********",
      ),
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
    );
  }

  Widget _buildemail() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: "Email Address", hintText: "youremail@gmail.com"),
      style: TextStyle(fontSize: 12),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please Enter your Email';
        }
        return null;
      },
      onSaved: (value) {
        _email = value!;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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
                  height: 15,
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
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
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
                            height: 15,
                          ),
                          Text(
                            "SIGN IN",
                            style: TextStyle(
                                color: Color.fromARGB(255, 72, 158, 228),
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                          SizedBox(
                            height: 35,
                          ),
                          Form(
                              key: _formkey,
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    _buildemail(),
                                    _buildPassword(),
                                    SizedBox(
                                      height: 10,
                                    ),
                                  ])),

                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                forgetpassword()));
                                  },
                                  child: Text(
                                    "Forgot password?",
                                    style: TextStyle(color: Colors.black),
                                  )),
                            ],
                          ),
                          SizedBox(
                            height: 45,
                          ),

                          //  Added button

                          Container(
                            height: 40,
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            width: 200,
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formkey.currentState!.validate()) {
                                  _formkey.currentState!.save();
                                  toastmessage("Login Successfully!");
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => MyApp()));
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
                                "LOG IN",
                              ),
                            ),
                          ),

                          // roundbutton(
                          //     title: "Login",
                          //      tapfun: () {
                          //       FirebaseAuth.instance
                          //           .signInWithEmailAndPassword(
                          //               email: emailcon.text.toString(),
                          //               password: passwordcon.text.toString())
                          //           .then((value) {
                          //         Navigator.push(
                          //             context,
                          //             MaterialPageRoute(
                          //                 builder: (context) =>
                          //                     MyApp()));
                          //       }).onError((error, stackTrace) {
                          //         toastmessage(error.toString());
                          //       });
                          //     }),
                        ],
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
                    "Don't have an account",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        toastmessage("Please Sign Up");
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => signUpScreen()));
                      },
                      child: Text(
                        "Sign Up",
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


String? validateEmail(String value) {
  bool emailValid = RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(value);
  return !emailValid ? 'Enter a Valid Email Address' : null;
}

String? validatePassword(String value) =>
    value.length < 6 ? 'Password should be more than 5 Characters' : null;
