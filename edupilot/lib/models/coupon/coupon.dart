import 'package:flutter/material.dart';

class Coupon{
  Coupon({
    required this.id,
    required this.icon,
    required this.name,
    required this.description,
    required this.fee,
  });

  final String id;
  final IconData? icon;
  final String name;
  final String description;
  final int fee;
}