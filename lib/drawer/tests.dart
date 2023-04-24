import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class TestsPage extends StatefulWidget {
  @override
  _TestsPageState createState() => _TestsPageState();
}

class _TestsPageState extends State<TestsPage> {
 final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();
  final _messageController = TextEditingController();
  List<Card> _testcard = [];


  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _dateController.dispose();
    _messageController.dispose();
    super.dispose();
  }
  Future<void> _selectDate(BuildContext context) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2000),
    lastDate: DateTime(2100),
  );

  if (picked != null) {
    String formattedDate = DateFormat('yyyy-MM-dd').format(picked);
    setState(() {
      _dateController.text = formattedDate;
    });
  }
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
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Test'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                 TextField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    hintText: 'Course Code',
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    hintText: 'Venue',
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _dateController,
                  onTap: () async {
                    FocusScope.of(context).requestFocus(new FocusNode());
                    await _selectDate(context);
                    
                  },
                  decoration: InputDecoration(
                    hintText: 'Date',
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
              ],
            ),
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
                // Perform the desired action here
                String title = _titleController.text;
                String description = _descriptionController.text;
                String date = _dateController.text;
                String time = _timeController.text;
                String message = _messageController.text;

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
                                fontWeight: FontWeight.bold, fontSize: 10, color: Colors.brown),
                          ),
                          Text(
                            date,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 10, color: Colors.redAccent),
                          ),
                          Text(
                            time,
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
                                dispose();
                              }
                            },
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                              description,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 10, color: Colors.green),
                            ),
                          
                        ],
                      )
                    ],
                  ),
                ));
                 setState(() {
                  _testcard.add(newCard);
                });
                // You can now use the values of the text fields as needed
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
          children: _testcard,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showDialog,
        child: Icon(Icons.add),
      ),
    );
  }
}
