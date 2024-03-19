import 'package:flutter/material.dart';

import 'User.dart';
import 'main.dart';

class DoctorPage extends StatelessWidget {
  const DoctorPage({super.key, required this.user});
  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hello Dr. ${user.firstName}"),
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
                      builder: (context) => DoctorPage(user: user)),
                );
              },
            ),
            ListTile(
              title: const Text('Availabilities'),
              leading: Icon(Icons.calendar_month),
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
      body: Center(
        child: Column(
          children: [
            Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Center(
                    child: Text("Appointments today:",
                        style: Theme.of(context).textTheme.headline4)),
                const SizedBox(
                  height: 10,
                ),
                Center(child: Text("No appointments today",
                    style: Theme.of(context).textTheme.headline4)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
