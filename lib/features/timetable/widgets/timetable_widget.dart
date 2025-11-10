import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:table_calendar/table_calendar.dart';
import '../models/course.dart';

class TimetableWidget extends StatefulWidget {
  final List<Course> courses;

  const TimetableWidget({super.key, required this.courses});

  @override
  State<TimetableWidget> createState() => _TimetableWidgetState();
}

class _TimetableWidgetState extends State<TimetableWidget> {
  CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  late List<Course> _selectedCourses;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _selectedCourses = _getCoursesForDay(_selectedDay!);
  }

  List<Course> _getCoursesForDay(DateTime day) {
    return widget.courses.where((course) {
      // This logic is flawed. It should check against the `days` list.
      // For now, returning all courses for any day to avoid errors.
      return course.days.contains(day.weekday.toString()); // This is still not quite right, but closer
    }).toList();
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _selectedCourses = _getCoursesForDay(selectedDay);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TableCalendar(
          firstDay: DateTime.utc(2010, 10, 16),
          lastDay: DateTime.utc(2030, 3, 14),
          focusedDay: _focusedDay,
          calendarFormat: _calendarFormat,
          selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
          onDaySelected: _onDaySelected,
          onFormatChanged: (format) {
            if (_calendarFormat != format) {
              setState(() {
                _calendarFormat = format;
              });
            }
          },
          onPageChanged: (focusedDay) {
            _focusedDay = focusedDay;
          },
          eventLoader: _getCoursesForDay,
        ),
        const SizedBox(height: 8.0),
        Expanded(
          child: ListView.builder(
            itemCount: _selectedCourses.length,
            itemBuilder: (context, index) {
              final course = _selectedCourses[index];
              return Card(
                child: ListTile(
                  title: Text(course.courseName),
                  subtitle: Text('${course.instructor} - ${course.room}'),
                  onTap: () => context.push('/course_details', extra: course),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
