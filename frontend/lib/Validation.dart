
String? validateAccreditationNumber(String? value) {
  if (value == null || value.isEmpty) {
    return 'Accreditation number cannot be blank';
  } else if (value.length < 5) {
    return 'Enter valid accreditation number';
  } else {
    return null;
  }
}

String? validateFirstName(String? value) {
  if (value == null || value.isEmpty)
    return 'First name cannot be blank';
  else
    return null;
}

String? validateLastName(String? value) {
  if (value == null || value.isEmpty)
    return 'Last name cannot be blank';
  else
    return null;
}

String? validateEmail(String? value) {
  String pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = RegExp(pattern);
  if (value == null || value.isEmpty) {
    return 'Email cannot be blank';
  } else if (!regex.hasMatch(value)) {
    return 'Enter a valid email address';
  } else {
    return null;
  }
}

String? validateMobile(String? value) {
  String pattern = r'^[+0-9][0-9]*';
  RegExp regex = RegExp(pattern);
  if (value == null || value.isEmpty) {
    return 'Mobile number cannot be blank';
  } else if (!regex.hasMatch(value)) {
    return 'Enter valid mobile number';
  } else {
    return null;
  }
}

String? validateAddress(String? value) {
  if (value == null || value.isEmpty)
    return 'Address cannot be blank';
  else
    return null;
}

String? validatePassword(String? value) {
  String pattern =
      r'^(?=.*[0-9])(?=.*[!@#$%^&*])[a-zA-Z0-9!@#$%^&*]{8,16}$';
  RegExp regex = RegExp(pattern);
  if (value == null || value.isEmpty) {
    return 'Password cannot be blank';
  } else if (!regex.hasMatch(value)) {
    return 'Password must be 8-16 characters and contain at least: \n        - 1 uppercase letter [A-Z]\n        - 1 lowercase letter [a-z]\n        - 1 number [0-9]\n        - 1 special character [!@#\$%^&*]';
  } else {
    return null;
  }
}

String? validateConfirmPassword({required String? value, required String? password}) {
  if (value == null || value.isEmpty) {
    return 'Password cannot be blank';
  } else if (password != value) {
    return 'Passwords do not match';
  } else {
    return null;
  }
}