import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/course.dart';
import 'providers/courses_provider.dart';
import 'add_edit_course_screen.dart';
import 'utils/export_utils.dart';

class CourseListScreen extends StatelessWidget {
  const CourseListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final coursesProvider = Provider.of<CoursesProvider>(context);
    final List<Course> courses = coursesProvider.courses;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Courses'),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () => exportToExcel(context, courses),
            tooltip: 'Export to Excel',
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: courses.length,
        itemBuilder: (context, index) {
          final course = courses[index];
          return Dismissible(
            key: Key(course.id),
            direction: DismissDirection.endToStart,
            onDismissed: (_) {
              coursesProvider.deleteCourse(course.id);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${course.courseName} deleted'),
                  action: SnackBarAction(
                    label: 'Undo',
                    onPressed: () => coursesProvider.addCourse(course),
                  ),
                ),
              );
            },
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 20.0),
              child: const Icon(Icons.delete, color: Colors.white),
            ),
            child: ListTile(
              title: Text(course.courseName),
              subtitle: Text(course.courseCode),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => AddEditCourseScreen(course: course),
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const AddEditCourseScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
