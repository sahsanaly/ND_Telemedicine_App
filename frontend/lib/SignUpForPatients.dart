import 'dart:convert';

import 'package:flutter/material.dart';

import 'DateOfBirthWidget.dart';
import 'package:intl/intl.dart';

import 'User.dart';
import 'PatientPage.dart';
import 'package:http/http.dart' as http;

import 'Validation.dart';

class SignUpForPatients extends StatefulWidget {
  const SignUpForPatients({super.key});

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<SignUpForPatients> {
  final _formKey = GlobalKey<FormState>();
  final String title = "Patient Sign Up";
  bool signInFailed = false;

  DateTime? dateOfBirth;
  String? firstNameInput;
  String? lastNameInput;
  String? mobileInput;
  String? addressInput;
  String? emailInput;
  String? passwordInput;
  String? confirmPasswordInput;

  @override
  Widget build(BuildContext context) {
    final firstNameController = TextEditingController(text: firstNameInput);
    final lastNameController = TextEditingController(text: lastNameInput);
    final mobileNumberController = TextEditingController(text: mobileInput);
    final addressController = TextEditingController(text: addressInput);
    final emailController = TextEditingController(text: emailInput);
    final passwordController = TextEditingController(text: passwordInput);
    final confirmPasswordController =
        TextEditingController(text: confirmPasswordInput);

    // Build a Form widget using the _formKey created above.
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          children: [
            // const SizedBox(height: 10),
            // Text(
            //     "Welcome!",
            //     style: Theme.of(context).textTheme.headline3
            // ),
            const SizedBox(height: 10),
            Text("Please enter your details below",
                style: Theme.of(context).textTheme.headline1),
            const SizedBox(height: 20,),
            TextFormField(
              controller: firstNameController,
              decoration: const InputDecoration(
                hintText: "First name",
              ),
              validator: validateFirstName,
            ),
            const SizedBox(height: 10,),
            TextFormField(
              controller: lastNameController,
              decoration: const InputDecoration(
                hintText: "Last name",
              ),
              validator: validateLastName,
            ),
            const SizedBox(
              height: 10,
            ),
            if (signInFailed) ...[
              const SizedBox(
                height: 8,
              ),
              const Text(
                "An account with that email or mobile number already exists",
                style: TextStyle(color: Colors.red),
              ),
            ],
            Row(
              children: [
                SizedBox(
                  width: 160,
                  child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          firstNameInput = firstNameController.text;
                          lastNameInput = lastNameController.text;
                          mobileInput = mobileNumberController.text;
                          addressInput = addressController.text;
                          emailInput = emailController.text;
                          passwordInput = passwordController.text;
                          confirmPasswordInput = confirmPasswordController.text;
                        });

                        showDateOfBirthWidget(context);
                      },
                      child: const Text("Date of birth")),
                ),
                if (dateOfBirth != null) ...[
                  SizedBox(
                    width: 160,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: Text(
                        DateFormat('dd/MM/yyyy').format(dateOfBirth!),
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ],
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: mobileNumberController,
              decoration: const InputDecoration(
                hintText: "Mobile number",
              ),
              validator: validateMobile,
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: addressController,
              decoration: const InputDecoration(
                hintText: "Address",
              ),
              validator: validateAddress,
            ),
            const SizedBox(
              height: 10,
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
              obscureText: true,
              decoration: const InputDecoration(
                hintText: "Password",
              ),
              validator: validatePassword,
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: confirmPasswordController,
              obscureText: true,
              decoration: const InputDecoration(
                hintText: "Confirm your password",
              ),
              validator: (value) {
                return validateConfirmPassword(
                    value: value, password: passwordController.text);
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 250,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {

                        final response = await http.post(
                          // 10.0.2.2 replaces localhost when using android emulator
                            Uri.parse('http://localhost:8080/ndt/users'),
                            headers: {
                              'Content-Type': 'application/json; charset=UTF-8',
                            },
                            body: jsonEncode({
                              "firstName": firstNameController.text,
                              "lastName": lastNameController.text,
                              "dateOfBirth":
                              DateFormat('yyyy-MM-dd').format(dateOfBirth!),
                              "email": emailController.text,
                              "password": passwordController.text,
                              "address": addressController.text,
                              "phoneNum": mobileNumberController.text,
                              "role": "PA",
                              "verified": 1,
                              "active": 1
                            }));

                        if (response.body.isNotEmpty) {
                          Map<String, dynamic> userMap = jsonDecode(response.body);
                          User user = User.fromJson(userMap);
                          if (user.email.isNotEmpty) {
                            // Create profile object HERE
                            final responseProfile = await http.post(
                              // 10.0.2.2 replaces localhost when using android emulator
                                Uri.parse(
                                    'http://localhost:8080/ndt/pa-healthinfo/save'),
                                headers: {
                                  'Content-Type': 'application/json; charset=UTF-8',
                                },
                                body: jsonEncode({
                                  "userId": user.userId,
                                  "height": 170.0,
                                  "weight": 65.0,
                                  "healthStatus": "Great"
                                }));

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PatientPage(user: user)),
                            );
                          }
                        } else {
                          setState(() {
                            signInFailed = true;
                            emailInput = emailController.text;
                          });
                        }
                      }
                    },
                    child: const Text('Sign Up'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> showDateOfBirthWidget(BuildContext context) async {
    final datePicked = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DateOfBirthWidget()),
    );

    if (!mounted) return;

    setState(() {
      dateOfBirth = datePicked;
    });
  }
}
