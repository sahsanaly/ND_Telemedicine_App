import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_calendar_widget/flutter_calendar_widget.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'Booking.dart';
import 'PatientPage.dart';
import 'Profile.dart';
import 'User.dart';
import 'main.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({super.key, required this.user});
  final User user;

  @override
  BookingFormState createState() {
    return BookingFormState();
  }
}

class BookingFormState extends State<BookingPage> {
  final String title = "Booking";
  List<Booking> _selectedEvents = [];
  late Map<int, User> allUsers;

  String alertTitle = "";
  String alertBody = "";

  late EventList<Booking> allAvailabilities;

  DateTime dateSelected = DateTime.now();

  @override
  void initState() {
    super.initState();

    getData();
  }

  Future<EventList<Booking>> getData() async {
    allAvailabilities = await getAllAvailableBookings();
    allUsers = await getAllUsers();

    return allAvailabilities;
  }

  Future<Map<int, User>> getAllUsers() async {
    Map<int, User> allUsers = {0: widget.user};

    final response = await http.get(
      // 10.0.2.2 replaces localhost when using android emulator
      Uri.parse('http://localhost:8080/ndt/users'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    List<dynamic> userList = jsonDecode(response.body);
    for (var e in userList) {
      User user = User.fromJson(e);
      allUsers[user.userId] = user;
    }

    return allUsers;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        drawer: Drawer(
          width: 240,
          child: Column(
            children: [
              const SizedBox(
                height: 120.0,
                child: DrawerHeader(
                  decoration: BoxDecoration(color: Colors.green),
                  child: Text('Neighbourhood Doctors Telemedicine'),
                ),
              ),
              ListTile(
                title: const Text('Home'),
                leading: Icon(Icons.home),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PatientPage(user: widget.user)),
                  );
                },
              ),
              ListTile(
                title: const Text('My Profile'),
                leading: Icon(Icons.person),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Profile(user: widget.user)),
                  );
                },
              ),
              ListTile(
                title: const Text('Book Appointment'),
                leading: Icon(Icons.calendar_month),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return BookingPage(user: widget.user);
                  }));
                },
              ),
              Divider(
                height:20,
              ),
              ListTile(
                title: const Text('Log Out'),
                leading: Icon(Icons.logout),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const MyApp();
                  }));
                },
              ),
            ],
          ),
        ),
        body: FutureBuilder(
            future: getData(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                // Future hasn't finished yet, return a placeholder
                return SafeArea(
                  child: Column(
                    children: [
                      FlutterCalendar(
                          selectionMode: CalendarSelectionMode.single,
                          onDayPressed: (DateTime date) {
                            setState(() {
                              dateSelected = date;
                            });
                          }),
                      Text("Calendar Loading..."),
                    ],
                  ),
                );
              }
              return Container(
                alignment: Alignment.topLeft,
                child: Column(
                  children: [
                    FlutterCalendar(
                        selectionMode: CalendarSelectionMode.single,
                        events: allAvailabilities,
                        onDayPressed: (DateTime date) {
                          setState(() {
                            dateSelected = date;
                          });
                          _selectedEvents = allAvailabilities.get(date);
                        }),
                    if (_selectedEvents.isNotEmpty) ...[
                      Text(
                          "Appointments available for ${DateFormat('dd MMM, yyyy').format(dateSelected)}"),
                    ] else ...[
                      Text("No appointments available"),
                    ],
                    Column(
                      children: _selectedEvents
                          .map((e) => OutlinedButton(
                                onPressed: () {
                                  List<String> messages = [];

                                  // Set alertDialog messages
                                  messages.add("Confirm Booking");
                                  messages.add("You have selected:\n\n"
                                      "${e.bookingTime.substring(0, 5)} - ${e.bookingEndTime.substring(0, 5)}\n"
                                      "on ${DateFormat('dd MMM, yyyy').format(convertDate(e.bookingDate))} \n"
                                      "with Dr. ${allUsers[e.doctorId]?.firstName}");

                                  showAlertDialog(
                                      context, messages, e, widget.user);
                                },
                                child: Text(
                                    "${e.bookingTime.substring(0, 5)} - ${e.bookingEndTime.substring(0, 5)}"
                                    "   |   Dr. ${allUsers[e.doctorId]?.firstName}"),
                              ))
                          .toList(),
                    ),
                  ],
                ),
              );
            })); // This trailing comma makes auto-formatting nicer for build methods.
  }
}

Future<EventList<Booking>> getAllAvailableBookings() async {
  EventList<Booking> bookings;
  List<Booking> allAvailabilities = [];

  final response = await http.get(
// 10.0.2.2 replaces localhost when using android emulator
    Uri.parse('http://localhost:9000/booking/'),
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  bookings = EventList(events: {
    DateTime(2020, 01, 01): [
      Booking(
          1, 1, 2, "2020-01-01", "09:00:00", "09:15:00", "url", false, true),
    ]
  });
  // Need to initialise bookings then clear dummy data
  bookings.clear();

  if (response.body == "No availabilities found") {
    return bookings;
  } else {
    List<dynamic> bookingList = jsonDecode(response.body);

    for (var e in bookingList) {
      Booking booking = Booking.fromJson(e);
      allAvailabilities.add(booking);
    }

    for (var e in allAvailabilities) {
      DateTime date = convertDate(e.bookingDate);
      bookings.add(date, e);
    }

    return bookings;
  }
}

Future<bool> confirmBooking(Booking booking, User user) async {
  final response = await http.put(
      // 10.0.2.2 replaces localhost when using android emulator
      Uri.parse('http://localhost:9000/booking/update'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        "bookingId": booking.bookingId,
        "patientId": user.userId,
        "doctorId": booking.doctorId,
        "bookingDate": booking.bookingDate,
        "bookingTime": booking.bookingTime,
        "bookingEndTime": booking.bookingEndTime,
        "chatLink": booking.chatLink,
        "hasPaid": booking.hasPaid,
        "isAvailability": booking.isAvailability
      }));
  if (response.body.isNotEmpty) {
    return true;
  } else {
    return false;
  }
}

showAlertDialog(
    BuildContext context, List<String> messages, Booking booking, User user) {
  // set up the buttons
  Widget cancelButton = TextButton(
    child: Text("Cancel"),
    onPressed: () {
      Navigator.pop(context);
      // Navigator.push(context, MaterialPageRoute(builder: (context) => BookingPage(user: user)),);
    },
  );
  Widget continueButton = TextButton(
    child: Text("Confirm"),
    onPressed: () async {
      bool response = await confirmBooking(booking, user);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PatientPage(user: user)),
      );
    },
  );
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(messages[0]),
    content: Text(messages[1], textAlign: TextAlign.center),
    actions: [
      cancelButton,
      continueButton,
    ],
  );
  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
