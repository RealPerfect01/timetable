import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/course.dart';
import '../providers/courses_provider.dart';

class UpcomingClassesWidget extends StatelessWidget {
  const UpcomingClassesWidget({super.key});

  String _getTodayWeekday(DateTime now) {
    switch (now.weekday) {
      case DateTime.monday:
        return 'Mon';
      case DateTime.tuesday:
        return 'Tue';
      case DateTime.wednesday:
        return 'Wed';
      case DateTime.thursday:
        return 'Thu';
      case DateTime.friday:
        return 'Fri';
      case DateTime.saturday:
        return 'Sat';
      case DateTime.sunday:
        return 'Sun';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final coursesProvider = Provider.of<CoursesProvider>(context);
    final now = DateTime.now();
    final String today = _getTodayWeekday(now);

    final List<Course> upcomingClasses = coursesProvider.courses.where((course) {
      if (!course.days.contains(today)) {
        return false;
      }
      final courseStartDateTime = DateTime(now.year, now.month, now.day, course.startTime.hour, course.startTime.minute);
      return courseStartDateTime.isAfter(now);
    }).toList();

    upcomingClasses.sort((a, b) {
      final aStartTime = DateTime(now.year, now.month, now.day, a.startTime.hour, a.startTime.minute);
      final bStartTime = DateTime(now.year, now.month, now.day, b.startTime.hour, b.startTime.minute);
      return aStartTime.compareTo(bStartTime);
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Upcoming Classes Today',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        if (upcomingClasses.isEmpty)
          const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0),
              child: Text('No more classes for today!'),
            ),
          )
        else
          SizedBox(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: upcomingClasses.length,
              itemBuilder: (context, index) {
                final course = upcomingClasses[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          course.courseName,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8.0),
                        Text(course.room),
                        const SizedBox(height: 8.0),
                        Text('${course.startTime.format(context)} - ${course.endTime.format(context)}'),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
      ],
    );
  }
}
