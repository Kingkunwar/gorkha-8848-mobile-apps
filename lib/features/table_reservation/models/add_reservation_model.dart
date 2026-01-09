import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class AddReservationModel {
  String captcha;
  String date;
  String email;
  String message;
  String name;
  String persons;
  String phone;
  String time;
  AddReservationModel({
    required this.captcha,
    required this.date,
    required this.email,
    required this.message,
    required this.name,
    required this.persons,
    required this.phone,
    required this.time,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'captcha': captcha,
      'date': date,
      'email': email,
      'message': message,
      'name': name,
      'persons': int.parse(persons),
      'phone': phone,
      'time': time,
    };
  }

  factory AddReservationModel.fromMap(Map<String, dynamic> map) {
    return AddReservationModel(
      captcha: map['captcha'] as String,
      date: map['date'] as String,
      email: map['email'] as String,
      message: map['message'] as String,
      name: map['name'] as String,
      persons: map['persons'] as String,
      phone: map['phone'] as String,
      time: map['time'] as String,
    );
  }
}
