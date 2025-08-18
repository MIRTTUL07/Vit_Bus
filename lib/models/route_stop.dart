import 'package:flutter/material.dart';

class RouteStop {
  final String name;
  final String time;
  final IconData icon;
  final bool isCompleted;
  final bool isCurrent;

  RouteStop({
    required this.name,
    required this.time,
    required this.icon,
    this.isCompleted = false,
    this.isCurrent = false,
  });
}
