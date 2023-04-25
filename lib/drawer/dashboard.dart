import 'dart:async';

import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late DateTime _dateTime;

  @override
  void initState() {
    super.initState();
    _dateTime = DateTime.now();
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _dateTime = DateTime.now();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            ClockWidget(dateTime: _dateTime),
            SizedBox(width: 16),
            Text('ListView Cards Example'),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: _cards.length ~/ 2,
        itemBuilder: (context, index) {
          return Row(
            children: [
              Expanded(
                child: Card(
                  child: Column(
                    children: [
                      Text(
                        _cards[index * 2]['header']!,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        _cards[index * 2]['text']!,
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 10.0),
              Expanded(
                child: Card(
                  child: Column(
                    children: [
                      Text(
                        _cards[index * 2 + 1]['header']!,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        _cards[index * 2 + 1]['text']!,
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class ClockWidget extends StatelessWidget {
  const ClockWidget({required this.dateTime});

  final DateTime dateTime;

  @override
  Widget build(BuildContext context) {
    return Text(
      '${_formatTwoDigits(dateTime.hour)}:${_formatTwoDigits(dateTime.minute)}:${_formatTwoDigits(dateTime.second)}',
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  String _formatTwoDigits(int n) {
    return n.toString().padLeft(2, '0');
  }
}

final List<Map<String, String>> _cards = [  {    'header': 'Card 1',    'text': 'This is the text for card 1',  },  {    'header': 'Card 2',    'text': 'This is the text for card 2',  },  {    'header': 'Card 3',    'text': 'This is the text for card 3',  },  {    'header': 'Card 4',    'text': 'This is the text for card 4',  },];
