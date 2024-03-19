import 'package:flutter/material.dart';

import 'main.dart';

class NoAccess extends StatelessWidget {
  const NoAccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: Text("Access denied"),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              child: Column(
                children: [
                  const SizedBox(height: 10,),
                  Text("Unfortunately, your account is deactivated.",
                    style: Theme.of(context).textTheme.headline1
                  ),
                  const SizedBox(height: 10,),
                  Text("If you believe this is incorrect, please get in touch.",
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
