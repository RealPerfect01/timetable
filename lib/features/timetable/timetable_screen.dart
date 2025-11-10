import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'models/course.dart';
import 'providers/courses_provider.dart';
import 'widgets/timetable_widget.dart';
import 'widgets/upcoming_classes_widget.dart';

class TimetableScreen extends StatelessWidget {
  const TimetableScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final coursesProvider = Provider.of<CoursesProvider>(context);
    final List<Course> courses = coursesProvider.courses;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => context.go('/courses'),
            tooltip: 'Manage Courses',
          ),
        ],
      ),
      body: ListView(
        children: [
          const UpcomingClassesWidget(),
          const Divider(),
          TimetableWidget(courses: courses),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go('/add_course'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
