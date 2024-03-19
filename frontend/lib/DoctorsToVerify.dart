import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'AdminPage.dart';
import 'User.dart';
import 'main.dart';

class DoctorsToVerify extends StatefulWidget {
  const DoctorsToVerify({super.key, required this.user});
  final User user;

  @override
  VerifyDoctorsState createState() {
    return VerifyDoctorsState();
  }
}

class VerifyDoctorsState extends State<DoctorsToVerify> {
  List<User> unverifiedDoctors = [];

  @override
  void initState() {
    super.initState();

    getData();
  }

  Future<List<User>> getData() async {
    unverifiedDoctors = await getAllUnverifiedDoctors();

    return unverifiedDoctors;
  }

  Future<bool> approveDr(User user) async {

    final response = await http.post(
        // 10.0.2.2 replaces localhost when using android emulator
        Uri.parse('http://localhost:8080/ndt/doctors/approve'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          "userId": user.userId,
          "accreditation_num": user.accreditationNum,
          "firstName": user.firstName,
          "lastName": user.lastName,
          "dateOfBirth": user.dateOfBirth,
          "email": user.email,
          "password": user.password,
          "address": user.address,
          "phoneNum": user.phoneNum,
          "role": user.role,
          "active": user.active,
          "verified": user.verified
        }));

    if (response.body.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> denyDr(User user) async {
    final response = await http.post(
        // 10.0.2.2 replaces localhost when using android emulator
        Uri.parse('http://localhost:8080/ndt/doctors/deny'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          "userId": user.userId,
          "accreditation_num": user.accreditationNum,
          "firstName": user.firstName,
          "lastName": user.lastName,
          "dateOfBirth": user.dateOfBirth,
          "email": user.email,
          "password": user.password,
          "address": user.address,
          "phoneNum": user.phoneNum,
          "role": user.role,
          "active": user.active,
          "verified": user.verified
        }));

    if (response.body.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Verify doctors'),
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
                        builder: (context) => AdminPage(user: widget.user)),
                  );
                },
              ),
              ListTile(
                title: const Text('Verify Doctors'),
                leading: Icon(Icons.verified_outlined),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DoctorsToVerify(user: widget.user)),
                  );
                },
              ),
              ListTile(
                title: const Text('All Users'),
                leading: Icon(Icons.group),
                onTap: () {

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
                    child: Column(children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                      child: Text("Loading...",
                          style: Theme.of(context).textTheme.headline4))
                ]));
              }
              if (unverifiedDoctors.isEmpty) {
                return SafeArea(
                    child: Column(children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                      child: Text("No doctors to show",
                          style: Theme.of(context).textTheme.headline4)),
                ]));
              } else {
                return SafeArea(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: SingleChildScrollView(
                            child: Column(
                              children: unverifiedDoctors
                                  .map(
                                    (e) => Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8.0)),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          ListTile(
                                            leading: const Icon(Icons.person),
                                            title: Text(
                                                "${e.accreditationNum} | ${e.firstName} ${e.lastName}"),
                                            subtitle: Text(
                                                "${e.email} \n${e.phoneNum}"),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: <Widget>[
                                              TextButton(
                                                child: const Text('APPROVE'),
                                                onPressed: () async {
                                                  String message = "";
                                                  bool response =
                                                      await approveDr(e);
                                                  if (response) {
                                                    setState(() {
                                                      message =
                                                          'Doctor ${e.firstName} approved';
                                                    });
                                                  } else {
                                                    message =
                                                        'An error occured';
                                                  }
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                        content: Text(message)),
                                                  );
                                                },
                                              ),
                                              const SizedBox(width: 8),
                                              TextButton(
                                                child: const Text('DENY'),
                                                onPressed: () async {
                                                  String message = "";
                                                  bool response =
                                                      await denyDr(e);
                                                  if (response) {
                                                    setState(() {
                                                      message =
                                                          'Doctor ${e.firstName} denied';
                                                    });
                                                  } else {
                                                    message =
                                                        'An error occured';
                                                  }
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                        content: Text(message)),
                                                  );
                                                },
                                              ),
                                              const SizedBox(width: 8),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
            }));
  }
}

Future<List<User>> getAllUnverifiedDoctors() async {
  List<User> users = [];

  final response = await http.get(
// 10.0.2.2 replaces localhost when using android emulator
    Uri.parse('http://localhost:8080/ndt/doctors/unverified'),
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
  List<dynamic> list = jsonDecode(response.body);

  for (var dr in list) {
    User user = User.fromJson(dr);
    users.add(user);
  }
  return users;
}
