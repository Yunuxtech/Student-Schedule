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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 25.0),
            child: SizedBox(
              height: 80,
              child: Card(
                elevation: 100,
                child: Expanded(
                  child: Center(
                    child: ClockWidget(dateTime: _dateTime),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Card(
              elevation: 30,
              child: ListView.builder(
                itemCount: (_cards.length / 2).ceil(),
                itemBuilder: (context, index) {
                  final screenWidth = MediaQuery.of(context).size.width;
                  final cardWidth = (screenWidth - 30.0) / 2;
                  final screenHeight = MediaQuery.of(context).size.height;
                  final cardHeight = screenHeight;
                  return Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          width: cardWidth,
                          height: 160,
                          child: Card(
                            elevation: 30,
                            color: Colors.white70,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    // width: 70.0,
                                    // height: 50.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(35.0),
                                      color: Colors.white,
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Icons.account_circle,
                                        color: Colors.blue,
                                        size: 50.0,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10.0,
                                  height: 15,),
                                  Expanded(
                                    child: Container(
                                      height: 120,
                                      width: MediaQuery.of(context).size.width,
                                      padding: EdgeInsets.all(10.0),
                                      color: Colors.blue,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            _cards[index * 2]['header']!,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18.0,
                                              color: Colors.white,
                                            ),
                                          ),
                                          SizedBox(height: 10.0),
                                          Text(
                                            _cards[index * 2]['text']!,
                                            style: TextStyle(
                                              fontSize: 16.0,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10.0),
                      Expanded(
                        child: SizedBox(
                          width: cardWidth,
                          height: 160,
                          child: Card(
                            elevation: 30,
                            color: Colors.white70,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 50.0),
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
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
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
        fontSize: 50,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  String _formatTwoDigits(int n) {
    return n.toString().padLeft(2, '0');
  }
}

final List<Map<String, String>> _cards = [
  {
    'header': 'Lectures',
    'text': '#1',
  },
  {
    'header': 'Assignments',
    'text': '#2',
  },
  {
    'header': 'Notes',
    'text': '#3',
  },
  {
    'header': 'Tests',
    'text': '#4',
  },
  {
    'header': 'Exams',
    'text': '#5',
  },
  {
    'header': 'Total',
    'text': '#6',
  },
];
