import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Contact {
  final String firstname;
  final String lastname;
  final String phone;
  const Contact(
      {required this.firstname, required this.lastname, required this.phone});

  @override
  String toString() {
    // TODO: implement toString
    return " lastname :$firstname ,lastname :$lastname ,phone :$phone ";
  }

  factory Contact.fromJson(Map<String, dynamic> data) {
    return Contact(
        firstname: data["firstname"],
        lastname: data["lastname"],
        phone: data["phone"]);
  }
}
