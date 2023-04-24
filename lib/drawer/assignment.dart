import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AssignmentsPage extends StatefulWidget {
  @override
  _AssignmentPageState createState() => _AssignmentPageState();
}

class _AssignmentPageState extends State<AssignmentsPage> {
 final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _dateController = TextEditingController();
  final _messageController = TextEditingController();
  List<Card> _assignmentcard= [];

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

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Assignment'),
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
                TextField(
                  controller: _messageController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText: 'Given Assignment',
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
                String date = _dateController.text;
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
                                fontWeight: FontWeight.bold, fontSize: 10),
                          ),
                          Text(
                            date,
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
                            message,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 10),
                          ),
                        ],
                      )
                    ],
                  ),
                ));

                setState(() {
                  _assignmentcard.add(newCard);
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
          children: _assignmentcard,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showDialog,
        child: Icon(Icons.add),
      ),
    );
  }
}
