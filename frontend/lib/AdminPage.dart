import 'package:flutter/material.dart';
import 'package:frontend/DoctorsToVerify.dart';

import 'User.dart';
import 'main.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({super.key, required this.user});
  final String title = "Admin";
  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin - ${user.firstName}"),
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
                      builder: (context) => AdminPage(user: user)),
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
                      builder: (context) => DoctorsToVerify(user: user)),
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
      body: Container(
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Text(
                "Whose the boss in town?",
                style: Theme.of(context).textTheme.headline1
            ),
            const SizedBox(
              height: 50,
            ),
            Text(
                "You are!",
                style: Theme.of(context).textTheme.headline2
            ),
          ],
        ),
      ),
    );
  }
}
