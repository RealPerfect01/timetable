import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'models/course.dart';
import 'providers/courses_provider.dart';
import 'widgets/timetable_widget.dart';
import 'utils/export_utils.dart';

class TimetableScreen extends StatelessWidget {
  const TimetableScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final coursesProvider = Provider.of<CoursesProvider>(context);
    final List<Course> courses = coursesProvider.courses;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Timetable'),
        actions: [
          IconButton(
            icon: const Icon(Icons.list_alt),
            onPressed: () => context.push('/courses'),
            tooltip: 'Manage Courses',
          ),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () => exportToExcel(context, courses),
            tooltip: 'Export to Excel',
          ),
        ],
      ),
      body: TimetableWidget(courses: courses),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/add_course'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
