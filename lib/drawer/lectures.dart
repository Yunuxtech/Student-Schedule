import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';


class LecturesPage extends StatefulWidget {
  @override
  _LecturesPageState createState() => _LecturesPageState();
}

class _LecturesPageState extends State<LecturesPage> {
  final _titleController = TextEditingController();
  final _venueController = TextEditingController();
  final _timeController = TextEditingController();
  List<Card> _lecturecard = [];

  @override
  void dispose() {
    _titleController.dispose();
    _venueController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null)
      setState(() {
        final time = DateTime(2000, 1, 1, picked.hour, picked.minute);
        final timeString =
            '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
        _timeController.text = timeString;
      });
  }

  void _showDialog() {
    List<String> _days = [];
    bool isChecked1 = false;
    bool isChecked2 = false;
    bool isChecked3 = false;
    bool isChecked4 = false;
    bool isChecked5 = false;
    bool isChecked6 = false;
    bool isChecked7 = false;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Lectures'),
          content: SingleChildScrollView(
            child: ListBody(children: <Widget>[
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  hintText: 'Course Code',
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _venueController,
                decoration: InputDecoration(
                  hintText: 'Venue',
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _timeController,
                onTap: () async {
                  FocusScope.of(context).requestFocus(new FocusNode());
                  await _selectTime(context);
                },
                decoration: InputDecoration(
                  hintText: 'Time',
                ),
              ),
              SizedBox(height: 10),
              Text("Day(s)"),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Checkbox(
                      value: isChecked1,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked1 = value!;
                          print(isChecked1);
                        });
                        if (value!) {
                          _days.add('S');
                        } else {
                          _days.remove('S');
                        }
                       
                      },
                    ),
                    Text('S'),
                    Checkbox(
                      value: isChecked2,
                      onChanged: (value) {
                        setState(() {
                          isChecked2 = value!;
                        });
                        if (value!) {
                          _days.add('M');
                        } else {
                          _days.remove('M');
                        }
                      },
                    ),
                    Text('M'),
                    Checkbox(
                      value: isChecked3,
                      onChanged: (value) {
                        setState(() {
                          isChecked3 = value!;
                        });
                        if (value!) {
                          _days.add('T');
                        } else {
                          _days.remove('T');
                        }
                      },
                    ),
                    Text('T'),
                    Checkbox(
                      value: isChecked4,
                      onChanged: (value) {
                        setState(() {
                          isChecked4 = value!;
                        });
                        if (value!) {
                          _days.add('W');
                        } else {
                          _days.remove('W');
                        }
                      },
                    ),
                    Text('W'),
                    Checkbox(
                      value: isChecked5,
                      onChanged: (value) {
                        setState(() {
                          isChecked5 = value!;
                        });
                        if (value!) {
                          _days.add('TH');
                        } else {
                          _days.remove('TH');
                        }
                      },
                    ),
                    Text('TH'),
                    Checkbox(
                      value: isChecked6,
                      onChanged: (value) {
                        setState(() {
                          isChecked6 = value!;
                        });
                        if (value!) {
                          _days.add('F');
                        } else {
                          _days.remove('F');
                        }
                      },
                    ),
                    Text('F'),
                    Checkbox(
                      value: isChecked7,
                      onChanged: (value) {
                        setState(() {
                          isChecked7 = value!;
                        });
                        if (value!) {
                          _days.add('S');
                        } else {
                          _days.remove('S');
                        }
                      },
                    ),
                    Text('S'),
                  ],
                ),
              )
            ]),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Save'),
              onPressed: () {
                String title = _titleController.text;
                String _venue = _venueController.text;
                String _time = _timeController.text;
                List<String> selectedDays = [];
                if (isChecked1) selectedDays.add('S');
                if (isChecked2) selectedDays.add('M');
                if (isChecked3) selectedDays.add('T');
                if (isChecked4) selectedDays.add('W');
                if (isChecked5) selectedDays.add('TH');
                if (isChecked6) selectedDays.add('F');
                if (isChecked7) selectedDays.add('S');
                AnimatedSnackBar.rectangle(
                  'Success',
                  'Lecture Added',
                  type: AnimatedSnackBarType.success,
                  brightness: Brightness.light,
                  mobileSnackBarPosition: MobileSnackBarPosition
                      .bottom, // Position of snackbar on mobile devices
                  // desktopSnackBarPosition: DesktopSnackBarPosition.topRight,
                ).show(
                  context,
                );

                // toastmessage("Note Added");

                Card newCard = Card(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 10),
                          ),
                          Text(
                            _time,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 10),
                          ),
                          PopupMenuButton(
                            itemBuilder: (BuildContext context) {
                              return [
                                PopupMenuItem(
                                  child: Text('Edit'),
                                  value: "Edit",
                                ),
                                PopupMenuItem(
                                  child: Text('Delete'),
                                  value: "Delete",
                                ),
                              ];
                            },
                            onSelected: (value) {
                              // Do something when an option is selected
                              if (value == 'Edit') {
                                _showDialog();
                                // navigateToEditPage(item);
                              } else if (value == 'delete') {
                                // deleteById(id);
                              }
                            },
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            _venue,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 10),
                          ),
                        ],
                      )
                    ],
                  ),
                ));

                setState(() {
                  _lecturecard.add(newCard);
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: _lecturecard,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: _showDialog,
        child: Icon(Icons.add),
      ),
    );
  }
}
