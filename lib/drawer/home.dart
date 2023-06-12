import 'dart:io';

import 'package:Student_schedule/alarmFunctions/NotificationService.dart';
import 'package:Student_schedule/drawer/about.dart';
import 'package:Student_schedule/drawer/exams.dart';
import 'package:Student_schedule/drawer/tests.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
// import 'package:student_schedule/drawer/privacy_policy.dart';
// import 'package:student_schedule/drawer/send_feedback.dart';
// import 'package:student_schedule/drawer/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../loginscreen.dart';
import '../main.dart';
import '../services/auth.dart';
import 'notes.dart';
import 'dashboard.dart';
import 'assignment.dart';
import 'my_drawer_header.dart';
import 'notes.dart';
import 'lectures.dart';
import 'package:timezone/timezone.dart' as tz;

class HomePage extends StatefulWidget {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  const HomePage(this.auth, this.firestore);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var currentPage = DrawerSections.dashboard;

  bool _notificationsEnabled = false;

  @override
  void initState() {
    super.initState();
    _isAndroidPermissionGranted();
    _requestPermissions();
    // _configureDidReceiveLocalNotificationSubject();
    // _configureSelectNotificationSubject();
  }

  Future<void> _isAndroidPermissionGranted() async {
    if (Platform.isAndroid) {
      final bool granted = await NotificationService().flutterLocalNotificationsPlugin
              .resolvePlatformSpecificImplementation<
                  AndroidFlutterLocalNotificationsPlugin>()
              ?.areNotificationsEnabled() ??
          false;

      setState(() {
        _notificationsEnabled = granted;
      });
    }
  }

  Future<void> _requestPermissions() async {
    if (Platform.isIOS || Platform.isMacOS) {
      await NotificationService().flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
      await NotificationService().flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              MacOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
    } else if (Platform.isAndroid) {
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
          NotificationService().flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();

      final bool? granted = await androidImplementation?.requestPermission();
      setState(() {
        _notificationsEnabled = granted ?? false;
      });
    }
  }

  // void _configureDidReceiveLocalNotificationSubject() {
  //   didReceiveLocalNotificationStream.stream
  //       .listen((ReceivedNotification receivedNotification) async {
  //     await showDialog(
  //       context: context,
  //       builder: (BuildContext context) => CupertinoAlertDialog(
  //         title: receivedNotification.title != null
  //             ? Text(receivedNotification.title!)
  //             : null,
  //         content: receivedNotification.body != null
  //             ? Text(receivedNotification.body!)
  //             : null,
  //         actions: <Widget>[
  //           CupertinoDialogAction(
  //             isDefaultAction: true,
  //             onPressed: () async {
  //               Navigator.of(context, rootNavigator: true).pop();
  //               await Navigator.of(context).push(
  //                 MaterialPageRoute<void>(
  //                   builder: (BuildContext context) =>
  //                       SecondPage(receivedNotification.payload),
  //                 ),
  //               );
  //             },
  //             child: const Text('Ok'),
  //           )
  //         ],
  //       ),
  //     );
  //   });
  // }

  // void _configureSelectNotificationSubject() {
  //   selectNotificationStream.stream.listen((String? payload) async {
  //     await Navigator.of(context).push(MaterialPageRoute<void>(
  //       builder: (BuildContext context) => SecondPage(payload),
  //     ));
  //   });
  // }

  // //My need is here
  // Future<void> _scheduleWeeklyMondayTenAMNotification(
  //     {int day = 1, int hour = 00, int minute = 00}) async {
  //   await flutterLocalNotificationsPlugin.zonedSchedule(
  //       0,
  //       'weekly scheduled notification title',
  //       'weekly scheduled notification body',
  //       _nextInstanceOfMondayTenAM(),
  //       const NotificationDetails(
  //         android: AndroidNotificationDetails('weekly notification channel id',
  //             'weekly notification channel name',
  //             channelDescription: 'weekly notificationdescription'),
  //       ),
  //       androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
  //       uiLocalNotificationDateInterpretation:
  //           UILocalNotificationDateInterpretation.absoluteTime,
  //       matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime);
  // }

  // tz.TZDateTime _nextInstanceOfMondayTenAM() {
  //   tz.TZDateTime scheduledDate = _nextInstanceOfTenAM();
  //   while (scheduledDate.weekday != DateTime.monday) {
  //     scheduledDate = scheduledDate.add(const Duration(days: 1));
  //   }
  //   return scheduledDate;
  // }

  // tz.TZDateTime _nextInstanceOfTenAM() {
  //   final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
  //   tz.TZDateTime scheduledDate =
  //       tz.TZDateTime(tz.local, now.year, now.month, now.day, 10);
  //   if (scheduledDate.isBefore(now)) {
  //     scheduledDate = scheduledDate.add(const Duration(days: 1));
  //   }
  //   return scheduledDate;
  // }

  // @override
  // void dispose() {
  //   didReceiveLocalNotificationStream.close();
  //   selectNotificationStream.close();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    var container;
    if (currentPage == DrawerSections.dashboard) {
      container = DashboardPage();
    } else if (currentPage == DrawerSections.lectures) {
      container = LecturesPage(widget.auth, widget.firestore);
    } else if (currentPage == DrawerSections.assignments) {
      container = AssignmentsPage(widget.auth, widget.firestore);
    } else if (currentPage == DrawerSections.notes) {
      container = NotesPage(widget.auth, widget.firestore);
    } else if (currentPage == DrawerSections.tests) {
      container = TestsPage(widget.auth, widget.firestore);
    } else if (currentPage == DrawerSections.exams) {
      container = ExamsPage(widget.auth, widget.firestore);
    } else if (currentPage == DrawerSections.about) {
      container = AboutPage();
    } else if (currentPage == DrawerSections.loginscreen) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  loginscreen(widget.auth, widget.firestore)));
    }
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text(
            "Student Activities Planner",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          iconTheme: IconThemeData(color: Colors.white),
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
              print('Oya get out');
              Auth(widget.auth).signOut();
              // currentPage = DrawerSections.loginscreen;
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      loginscreen(widget.auth, widget.firestore)));
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
