import 'package:flutter/material.dart';

class Course {
  final String id;
  final String courseName;
  final String courseCode;
  final String instructor;
  final List<String> days;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final String room;

  Course({
    required this.id,
    required this.courseName,
    required this.courseCode,
    required this.instructor,
    required this.days,
    required this.startTime,
    required this.endTime,
    required this.room,
  });
}
