class Booking {
  int bookingId;
  int patientId;
  int doctorId;
  String bookingDate;
  String bookingTime;
  String bookingEndTime;
  String chatLink;
  bool hasPaid;
  bool isAvailability;

  Booking(
      this.bookingId,
      this.patientId,
      this.doctorId,
      this.bookingDate,
      this.bookingTime,
      this.bookingEndTime,
      this.chatLink,
      this.hasPaid,
      this.isAvailability
      );

  factory Booking.fromJson(dynamic json) {
    return Booking(
        json['bookingId'],
        json['patientId'],
        json['doctorId'],
        json['bookingDate'],
        json['bookingTime'],
        json['bookingEndTime'],
        json['chatLink'],
        json['hasPaid'],
        json['isAvailability']
    );
  }
}

DateTime convertDate(String dateToConvert) {
  List<String> dateString = dateToConvert.split("-");
  List<int> dateInt = [];
  for (var i in dateString) {
    dateInt.add(int.parse(i));
  }
  DateTime date = DateTime(dateInt[0], dateInt[1], dateInt[2]);

  return date;
}