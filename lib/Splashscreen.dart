import 'dart:async';
import 'package:Student_schedule/drawer/dashboard.dart';
import 'package:Student_schedule/drawer/drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'Homescreen.dart';
import 'loginscreen.dart';

class splashscreen extends StatefulWidget {
  const splashscreen({super.key});

  @override
  State<splashscreen> createState() => _splashscreenState();
}

class _splashscreenState extends State<splashscreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    final user = FirebaseAuth.instance.currentUser;
    // final user = null;

    if (user != null) {
      print("User is not null");
      Timer(
        const Duration(seconds: 5),
        () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => MyApp())),
      );
    } else {
      print("user is null");
      Timer(
        const Duration(seconds: 5),
        () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => loginscreen())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(100),
                image: const DecorationImage(
                  image: AssetImage("img/clipart.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 50),
            const Text(
              'Loading...',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
