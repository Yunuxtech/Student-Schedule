import 'dart:async';
import 'package:Student_schedule/drawer/dashboard.dart';
import 'package:Student_schedule/drawer/home.dart';
import 'package:Student_schedule/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'Homescreen.dart';
import 'loginscreen.dart';


class SuperApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        // Initialize FlutterFire:
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          // Check for errors
          if (snapshot.hasError) {
            return const Scaffold(
              body: Center(
                child: Text("Error"),
              ),
            );
          }

          // Once complete, show your application
          if (snapshot.connectionState == ConnectionState.done) {
            return splashscreen();
          }

          // Otherwise, show something whilst waiting for initialization to complete
          // return const Scaffold(
          //   body: Center(
          //     child: Text("Loading..."),
          //   ),
          // );
          return splashscreen();
        },
      ),
    );
  }
}

class Root extends StatefulWidget {
  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth(_auth).user,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.data?.uid == null) {
            return loginscreen(_auth, _firestore);
          } else {
            return HomePage(_auth, _firestore);
          }
        } 
        return loginscreen(_auth, _firestore); 
        // else {
        //   return const Scaffold(
        //     body: Center(
        //       child: Text("Loading..."),
        //     ),
        //   );
        // }
      }, //Auth stream
    );
  }
}

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

    Timer(
        const Duration(seconds: 5),
        () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => Root())),
      );
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
