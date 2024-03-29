import 'dart:ui';
import 'package:Student_schedule/drawer/dashboard.dart';
import 'package:Student_schedule/services/auth.dart';
import 'package:Student_schedule/services/database.dart';
import 'package:animated_snack_bar/animated_snack_bar.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'Component.dart';
import 'Toast.dart';
import 'Homescreen.dart';
import 'package:flutter/material.dart';

import 'drawer/home.dart';
import 'loginscreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class signUpScreen extends StatefulWidget {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  const signUpScreen(this.auth, this.firestore);

  @override
  State<signUpScreen> createState() => _signUpScreenState();
}

class _signUpScreenState extends State<signUpScreen> {
  late String _email;
  late String _password;
  late String _regno;
  late String _firstName;
  late String _lastName;
  final _formkey = GlobalKey<FormState>();
  bool isChecked = true;

  var db = FirebaseFirestore.instance;

  // var em

// add form
  Widget _buildemail() {
    return TextFormField(
      controller: _emailController,
      decoration: const InputDecoration(
          labelText: "Email",
          hintText: "youremail@gmail.com",
          fillColor: Colors.red),
      style: const TextStyle(
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
    );
  }

  Widget _buildFirst() {
    return TextFormField(
      controller: _firstNameController,
      decoration: const InputDecoration(
          labelText: "First Name",
          hintText: "First Name",
          fillColor: Colors.red),
      style: const TextStyle(
        fontSize: 12,
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please Enter your First Name';
        }
        return null;
      },
      onSaved: (value) {
        _firstName = value!;
      },
    );
  }

  Widget _buildSurname() {
    return TextFormField(
      controller: _surnameController,
      decoration: const InputDecoration(
          labelText: "Surname", hintText: "Surname", fillColor: Colors.red),
      style: const TextStyle(
        fontSize: 12,
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please Enter your Surname';
        }
        return null;
      },
      onSaved: (value) {
        _lastName = value!;
      },
    );
  }

  Widget _buildPassword() {
    return TextFormField(
      obscureText: false,
      controller: _passwordController,
      decoration:
          const InputDecoration(labelText: "Password", hintText: "********"),
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

  Widget _buildRegNo() {
    return TextFormField(
      controller: _regNoController,
      decoration: const InputDecoration(
          labelText: "Registraion No.", hintText: "CST/17/IFT/...."),
      style: const TextStyle(fontSize: 12),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please Enter your Reg.No';
        }
        return null;
      },
      onSaved: (value) {
        _regno = value!;
      },
    );
  }

  TextEditingController _regNoController = TextEditingController();
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _surnameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _regNoController.dispose();
    _firstNameController.dispose();
    _surnameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

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
                    const SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Container(
                        width: MediaQuery.of(context).size.height * 0.4,
                        height: 540,
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
                                height: 5,
                              ),
                              const Text(
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
                                      _buildRegNo(),
                                      _buildFirst(),
                                      _buildSurname(),
                                      _buildemail(),
                                      _buildPassword(),
                                    ]),
                              ),

                              const SizedBox(
                                height: 40,
                              ),

                              //  added button
                              Container(
                                height: 40,
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                width: 200,
                                child: ElevatedButton(
                                  autofocus: false,
                                  onPressed: () async {
                                    if (_formkey.currentState!.validate()) {
                                      _formkey.currentState!.save();

                                      // create user on firebase and data on firstore

                                      try {
                                        UserCredential creds =
                                            await Auth(widget.auth)
                                                .createAccount(
                                                    _email, _password);

                                        if (creds.user != null) {
                                          final user = <String, dynamic>{
                                            "firstName": _firstName,
                                            "lastName": _lastName,
                                            "regNo": _regno,
                                            "email": _email,
                                            "uid": creds.user!.uid,
                                          };
                                          DocumentReference value =
                                              await Database(widget.firestore)
                                                  .addStudent(user, "students");
                                          if (value.id != null) {
                                            print("Success");
                                            AnimatedSnackBar.rectangle(
                                              'Success',
                                              'Sign up Successful',
                                              type:
                                                  AnimatedSnackBarType.success,
                                              brightness: Brightness.light,
                                              mobileSnackBarPosition:
                                                  MobileSnackBarPosition.bottom,
                                            ).show(
                                              context,
                                            );

                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        HomePage(widget.auth,
                                                            widget.firestore)));
                                          }
                                        }
                                      } catch (e) {
                                        print("Encountered an error: $e");
                                        AnimatedSnackBar.rectangle(
                                          'Error',
                                          '$e',
                                          type: AnimatedSnackBarType.info,
                                          brightness: Brightness.light,
                                          mobileSnackBarPosition:
                                              MobileSnackBarPosition
                                                  .bottom, // Position of snackbar on mobile devices
                                          // desktopSnackBarPosition: DesktopSnackBarPosition.topRight,
                                        ).show(
                                          context,
                                        );

                                        _regNoController.clear();
                                        _firstNameController.clear();
                                        _surnameController.clear();
                                        _emailController.clear();
                                        _passwordController.clear();
                                      }
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
                                      const Color.fromARGB(255, 84, 169, 219),
                                    ),
                                  ),
                                  child: const Text(
                                    "SIGN UP",
                                  ),
                                ),
                              ),

                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "Already have an account?",
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      loginscreen(widget.auth,
                                                          widget.firestore)));
                                        },
                                        child: const Text(
                                          "Login",
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
