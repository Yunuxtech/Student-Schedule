import 'package:Student_schedule/drawer/about.dart';
import 'package:Student_schedule/drawer/exams.dart';
import 'package:Student_schedule/drawer/tests.dart';
// import 'package:student_schedule/drawer/privacy_policy.dart';
// import 'package:student_schedule/drawer/send_feedback.dart';
// import 'package:student_schedule/drawer/settings.dart';
import 'package:flutter/material.dart';


import '../loginscreen.dart';
import 'notes.dart';
import 'dashboard.dart';
import 'assignment.dart';
import 'my_drawer_header.dart';
import 'notes.dart';
import 'lectures.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var currentPage = DrawerSections.dashboard;

  @override
  Widget build(BuildContext context) {
    var container;
    if (currentPage == DrawerSections.dashboard) {
      container = DashboardPage();
    } else if (currentPage == DrawerSections.lectures) {
      container = LecturesPage();
    } else if (currentPage == DrawerSections.assignments) {
      container = AssignmentsPage();
    } else if (currentPage == DrawerSections.notes) {
      container = NotesPage();
    } else if (currentPage == DrawerSections.tests) {
      container = TestsPage();
    } else if (currentPage == DrawerSections.exams) {
      container = ExamsPage();
    } else if (currentPage == DrawerSections.about) {
      container = AboutPage();
    } else if (currentPage == DrawerSections.loginscreen) {
       Navigator.push(
      context,
      MaterialPageRoute(
      builder: (context) => loginscreen()));
    }
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          
          title: Text("Student Activities Planner", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold), ),
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: container,
        drawer: Drawer(
    
          child: SingleChildScrollView(
            child: Container(
              
              child: Column(
                children: [
                  MyHeaderDrawer(),
                  MyDrawerList(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget MyDrawerList() {
    return Container(
      
      padding: EdgeInsets.only(
        top: 15,
      ),
      child: Column(
        // shows the list of menu drawer
        children: [
          menuItem(1, "Dashboard", Icons.dashboard_outlined,
              currentPage == DrawerSections.dashboard ? true : false),
          menuItem(2, "Lectures", Icons.schedule,
              currentPage == DrawerSections.lectures ? true : false),
          menuItem(3, "Assignment", Icons.assignment,
              currentPage == DrawerSections.assignments ? true : false),
          menuItem(4, "Notes", Icons.notes,
              currentPage == DrawerSections.notes ? true : false),
          Divider(),
          menuItem(5, "Test Schedules", Icons.schedule,
              currentPage == DrawerSections.tests ? true : false),
          menuItem(6, "Exams Schedules", Icons.schedule,
              currentPage == DrawerSections.exams ? true : false),
          Divider(),
          menuItem(7, "About", Icons.question_mark_rounded,
              currentPage == DrawerSections.about ? true : false),
          menuItem(8, "Logout", Icons.logout,
              currentPage == DrawerSections.loginscreen ? true : false),
        ],
      ),
    );
  }

  Widget menuItem(int id, String title, IconData icon, bool selected) {
    return Material(
      color: selected ? Colors.grey[300] : Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          setState(() {
            if (id == 1) {
              currentPage = DrawerSections.dashboard;
            } else if (id == 2) {
              currentPage = DrawerSections.lectures;
            } else if (id == 3) {
              currentPage = DrawerSections.assignments;
            } else if (id == 4) {
              currentPage = DrawerSections.notes;
            } else if (id == 5) {
              currentPage = DrawerSections.tests;
            } else if (id == 6) {
              currentPage = DrawerSections.exams;
            } else if (id == 7) {
              currentPage = DrawerSections.about;
            } else if (id == 8) {
              currentPage = DrawerSections.loginscreen;
            }
          });
        },
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Row(
            children: [
              Expanded(
                child: Icon(
                  icon,
                  size: 20,
                  color: Colors.black,
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum DrawerSections {
  dashboard,
  lectures,
  assignments,
  notes,
  tests,
  exams,
  about,
  loginscreen,
}
