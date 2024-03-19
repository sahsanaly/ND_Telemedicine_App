class User {
  int userId;
  String role;
  bool active;
  bool verified;
  String firstName;
  String lastName;
  String dateOfBirth;
  String email;
  String password;
  String address;
  String phoneNum;
  int accreditationNum;

  User(
      this.userId,
      this.role,
      this.active,
      this.verified,
      this.firstName,
      this.lastName,
      this.dateOfBirth,
      this.email,
      this.password,
      this.address,
      this.phoneNum,
      this.accreditationNum,
      );

  factory User.fromJson(dynamic json) {
    return User(
        json['userId'],
        json['role'],
        json['active'],
        json['verified'],
        json['firstName'],
        json['lastName'],
        json['dateOfBirth'],
        json['email'],
        json['password'],
        json['address'],
        json['phoneNum'],
        json['accreditationNum']
    );
  }

}