import 'package:flutter/material.dart';
import 'models/course.dart';

class CourseDetailsScreen extends StatelessWidget {
  final Course course;

  const CourseDetailsScreen({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(course.courseName)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                leading: const Icon(Icons.school, color: Colors.blueAccent),
                title: Text(
                  course.courseName,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                subtitle: const Text('Course Name'),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                leading: const Icon(Icons.person, color: Colors.green),
                title: Text(
                  course.instructor,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                subtitle: const Text('Instructor'),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                leading: const Icon(Icons.room, color: Colors.orange),
                title: Text(
                  course.room,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                subtitle: const Text('Room'),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                leading: const Icon(Icons.access_time, color: Colors.purple),
                title: Text(
                  '${course.startTime.format(context)} - ${course.endTime.format(context)}',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                subtitle: const Text('Time'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
