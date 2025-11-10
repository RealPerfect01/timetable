import 'package:flutter/material.dart';
import '../models/course.dart';

class CoursesProvider with ChangeNotifier {
  final List<Course> _courses = [];

  List<Course> get courses => _courses;

  void addCourse(Course course) {
    _courses.add(course);
    notifyListeners();
  }

  void editCourse(Course course) {
    final index = _courses.indexWhere((c) => c.id == course.id);
    if (index != -1) {
      _courses[index] = course;
      notifyListeners();
    }
  }

  void deleteCourse(String id) {
    _courses.removeWhere((c) => c.id == id);
    notifyListeners();
  }
}
