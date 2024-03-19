import 'package:flutter/material.dart';

import 'main.dart';

class DoctorUnverified extends StatelessWidget {
  const DoctorUnverified({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sorry"),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 10,),
                  Text(
                      "Hold tight, our admin team will need to approve your account before you can start doing what you do best... ",
                    style: Theme.of(context).textTheme.headline1
                  ),
                  const SizedBox(height: 50,),
                  Text("For any further questions, get in touch.",
                      style: Theme.of(context).textTheme.headline4
                  ),
                  const SizedBox(height: 10,),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                    child: Column(
                      children: [
                        OutlinedButton(
                          child: Text("Return Home"),
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return const MyApp();
                            }));
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
