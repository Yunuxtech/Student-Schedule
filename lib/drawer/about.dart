import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  bool isChecked1 = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Card(
              elevation: 10,
              shadowColor: Colors.blue.withOpacity(1),
              child: Container(
                height: 400,
                width: 300,
                
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 40),
                        height: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage('img/clipart.png'),
              ),
            ),
                      ),
                      Text(
                        'App Name: Student Activities Planner',
                        style: TextStyle(fontSize: 15, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'App Version: v1.0',
                        style: TextStyle(fontSize: 15, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Developed By: Yunus Isah',
                        style: TextStyle(fontSize: 15, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),
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
