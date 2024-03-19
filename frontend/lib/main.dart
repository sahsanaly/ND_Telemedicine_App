import 'package:flutter/material.dart';

import 'BookingPage.dart';
import 'SignInPage.dart';
import 'SignUpForDoctors.dart';
import 'SignUpForPatients.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home',
      theme: ThemeData(
        primarySwatch: Colors.green,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            shadowColor: Colors.greenAccent,
            elevation: 3,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)),
            minimumSize: const Size(100, 40), //////// HERE
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
        ),
        textTheme: const TextTheme(
          bodyText1: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400,),
          headline1: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold,),
          headline2: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold,),
          headline3: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold,),
          headline4: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold,),

          // bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),
      ),
      home: const MyHomePage(title: 'Neighbourhood Doctors Telemedicine'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: 70),
                  Image.asset('assets/ndt.png', height: 100),
                  const SizedBox(height: 20),
                  Text(
                      "N D T",
                      style: Theme.of(context).textTheme.headline2

                  ),
                  const SizedBox(height: 70),
                  SizedBox(
                    width: 200,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return const SignInPage();
                          }));
                        },
                        child: const Text("Sign In")),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "No account yet? Sign up below",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 60),
                  SizedBox(
                    width: 200,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black54,
                          side: const BorderSide(
                              color: Colors.green,
                              style: BorderStyle.solid,
                              width: 1.2
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return const SignUpForPatients();
                          }));
                        },
                        child: const Text("Patient Sign Up")),
                  ),
                  const SizedBox(height: 2),
                  SizedBox(
                    width: 200,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black54,
                          side: const BorderSide(
                              color: Colors.green,
                              style: BorderStyle.solid,
                              width: 1.2
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return const SignUpForDoctors();
                          }));
                        },
                        child: const Text("Doctor Sign Up")),
                  ),
                  SizedBox(height: 50,),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
