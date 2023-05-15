import 'dart:ui';
import 'package:Student_schedule/services/auth.dart';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'Component.dart';

import 'package:flutter/material.dart';

import 'Forgetpassword.dart';
import 'Homescreen.dart';
import 'Loginwithphoneno.dart';
import 'SignUpScreen.dart';
import 'Toast.dart';
import 'drawer/home.dart';

class loginscreen extends StatefulWidget {
  const loginscreen(this.auth, this.firestore);

  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

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
      decoration: const InputDecoration(
        labelText: "Password",
        hintText: "********",
      ),
      style: const TextStyle(fontSize: 12),
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
      decoration: const InputDecoration(
          labelText: "Email Address", hintText: "youremail@gmail.com"),
      style: const TextStyle(fontSize: 12),
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

  void signUserIn() {}

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 4,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 72, 158, 228),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    const Center(
                      child: Text(
                        "Student App",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
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
                                offset: const Offset(0, 3),
                              ),
                            ]),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 80,
                              ),
                              const Text(
                                "SIGN IN",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 72, 158, 228),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Form(
                                key: _formkey,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    _buildemail(),
                                    _buildPassword(),
                                    const SizedBox(
                                      height: 30,
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
                                                          forgetpassword(
                                                              widget.auth,
                                                              widget
                                                                  .firestore)));
                                            },
                                            child: const Text(
                                              "Forgot password?",
                                              style: TextStyle(
                                                  color: Colors.black),
                                            )),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    Container(
                                      height: 40,
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      width: 200,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          if (_formkey.currentState!
                                              .validate()) {
                                            _formkey.currentState!.save();
                                            // toastmessage("Login Successfully!");
                                            final Future<String?> retVal =
                                                Auth(widget.auth)
                                                    .signIn(_email, _password);
                                            retVal.then((value) => {
                                                  if (value == "Success")
                                                    {
                                                      AnimatedSnackBar
                                                          .rectangle(
                                                        'Success',
                                                        'Login Successful ',
                                                        type:
                                                            AnimatedSnackBarType
                                                                .success,
                                                        brightness:
                                                            Brightness.light,
                                                        mobileSnackBarPosition:
                                                            MobileSnackBarPosition
                                                                .bottom, // Position of snackbar on mobile devices
                                                        // desktopSnackBarPosition: DesktopSnackBarPosition.topRight,
                                                      ).show(
                                                        context,
                                                      ),
                                                      Navigator.of(context).push(
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  HomePage(
                                                                      widget
                                                                          .auth,
                                                                      widget
                                                                          .firestore)))
                                                    }
                                                  else
                                                    {
                                                      AnimatedSnackBar
                                                          .rectangle(
                                                        'Error',
                                                        '$value',
                                                        type:
                                                            AnimatedSnackBarType
                                                                .info,
                                                        brightness:
                                                            Brightness.light,
                                                        mobileSnackBarPosition:
                                                            MobileSnackBarPosition
                                                                .bottom, // Position of snackbar on mobile devices
                                                        // desktopSnackBarPosition: DesktopSnackBarPosition.topRight,
                                                      ).show(
                                                        context,
                                                      )
                                                    }
                                                });
                                          }
                                        },
                                        style: ButtonStyle(
                                          shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                            const Color.fromARGB(
                                                255, 84, 169, 219),
                                          ),
                                        ),
                                        child: const Text(
                                          "LOG IN",
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Text(
                                            "Don't have an account",
                                            style: TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                          TextButton(
                                              onPressed: () {
                                                // toastmessage("Please Sign Up");
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            signUpScreen(
                                                                widget.auth,
                                                                widget
                                                                    .firestore)));
                                              },
                                              child: const Text(
                                                "Sign Up",
                                                style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 72, 158, 228),
                                                ),
                                              )),
                                        ],
                                      ),
                                    ),
                                  ],
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
            ],
          ),
        ),
      ),
    );
  }
}

// String? validateEmail(String value) {
//   bool emailValid = RegExp(
//           r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
//       .hasMatch(value);
//   return !emailValid ? 'Enter a Valid Email Address' : null;
// }

// String? validatePassword(String value) =>
//     value.length < 6 ? 'Password should be more than 5 Characters' : null;
