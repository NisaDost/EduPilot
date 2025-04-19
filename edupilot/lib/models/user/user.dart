import 'package:edupilot/models/user/role.dart';
import 'package:flutter/material.dart';

class User {

  User({
    required this.id,
    required this.firstName,
    this.middleName,
    required this.lastName,
    required this.password,
    required this.phoneNumber,
    required this.email,
    required this.avatar,
    required this.role,
  });

  final String id;
  final String firstName;
  final String? middleName;
  final String lastName;
  final String password;
  final String phoneNumber;
  final String email;
  Image avatar;
  final Role role;

}