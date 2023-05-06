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
                  child: Text(
                    'Card 1',
                    style: TextStyle(fontSize: 20),
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
