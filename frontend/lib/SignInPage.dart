import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/DoctorUnverified.dart';
import 'package:http/http.dart' as http;

import 'AdminPage.dart';
import 'DoctorPage.dart';
import 'PatientPage.dart';
import 'User.dart';
import 'NoAccess.dart';
import 'Validation.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final String title = "Sign In";
  bool signInFailed = false;
  String? emailInput;

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController(text: emailInput);
    final passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 10),
                Text("Welcome back!",
                    style: Theme.of(context).textTheme.headline3),
                const SizedBox(height: 10),
                Text("Please enter your details below",
                    style: Theme.of(context).textTheme.headline4),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    hintText: "Email",
                  ),
                  validator: validateEmail,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                    hintText: "Password",
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                if (signInFailed) ...[
                  const SizedBox(
                    height: 8,
                  ),
                  const Text(
                    "Incorrect email or password",
                    style: TextStyle(color: Colors.red),
                  ),
                ],
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 0),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final response = await http.post(
                            // 10.0.2.2 replaces localhost when using android emulator
                            Uri.parse('http://localhost:8080/ndt/login'),
                            headers: {
                              'Content-Type': 'application/json; charset=UTF-8',
                            },
                            body: jsonEncode({
                              "email": emailController.text,
                              "password": passwordController.text,
                            }));
                        if (response.body.isNotEmpty) {
                          Map<String, dynamic> userMap =
                              jsonDecode(response.body);
                          User user = User.fromJson(userMap);

                          if (user.active == true) {
                            if (user.role == "PA") {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        PatientPage(user: user)),
                              );
                            } else if (user.role == "DR" &&
                                user.verified == true) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        DoctorPage(user: user)),
                              );
                            } else if (user.role == "DR" &&
                                user.verified == false) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DoctorUnverified()),
                              );
                            } else if (user.role == "AD") {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        AdminPage(user: user)),
                              );
                            }
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NoAccess()),
                            );
                          }
                        } else {
                          passwordController.clear();
                          setState(() {
                            signInFailed = true;
                            emailInput = emailController.text;
                          });
                        }
                      }
                    },
                    child: const Text('Submit'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
