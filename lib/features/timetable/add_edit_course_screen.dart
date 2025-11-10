import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'models/course.dart';
import 'providers/courses_provider.dart';

class AddEditCourseScreen extends StatefulWidget {
  final Course? course;

  const AddEditCourseScreen({super.key, this.course});

  @override
  State<AddEditCourseScreen> createState() => _AddEditCourseScreenState();
}

class _AddEditCourseScreenState extends State<AddEditCourseScreen> {
  final _formKey = GlobalKey<FormState>();
  String _courseName = '';
  String _courseCode = '';
  String _instructor = '';
  List<String> _days = [];
  TimeOfDay _startTime = TimeOfDay.now();
  TimeOfDay _endTime = TimeOfDay.now();
  String _room = '';

  @override
  void initState() {
    super.initState();
    if (widget.course != null) {
      _courseName = widget.course!.courseName;
      _courseCode = widget.course!.courseCode;
      _instructor = widget.course!.instructor;
      _days = widget.course!.days;
      _startTime = widget.course!.startTime;
      _endTime = widget.course!.endTime;
      _room = widget.course!.room;
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final newCourse = Course(
        id: widget.course?.id ?? const Uuid().v4(),
        courseName: _courseName,
        courseCode: _courseCode,
        instructor: _instructor,
        days: _days,
        startTime: _startTime,
        endTime: _endTime,
        room: _room,
      );
      if (widget.course == null) {
        Provider.of<CoursesProvider>(
          context,
          listen: false,
        ).addCourse(newCourse);
      } else {
        Provider.of<CoursesProvider>(
          context,
          listen: false,
        ).editCourse(newCourse);
      }
      Navigator.of(context).pop();
    }
  }

  void _deleteCourse() {
    Provider.of<CoursesProvider>(
      context,
      listen: false,
    ).deleteCourse(widget.course!.id);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.course == null ? 'Add Course' : 'Edit Course'),
        actions: [
          if (widget.course != null)
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: _deleteCourse,
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: _courseName,
                decoration: const InputDecoration(labelText: 'Course Name'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a course name.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _courseName = value!;
                },
              ),
              TextFormField(
                initialValue: _courseCode,
                decoration: const InputDecoration(
                  labelText: 'Course Code (Optional)',
                ),
                onSaved: (value) {
                  _courseCode = value!;
                },
              ),
              TextFormField(
                initialValue: _instructor,
                decoration: const InputDecoration(
                  labelText: 'Instructor (Optional)',
                ),
                onSaved: (value) {
                  _instructor = value!;
                },
              ),
              const SizedBox(height: 10),
              const Text(
                'Days of the Week',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Wrap(
                spacing: 5.0,
                children: List<Widget>.generate(7, (int index) {
                  final day = [
                    'Mon',
                    'Tue',
                    'Wed',
                    'Thu',
                    'Fri',
                    'Sat',
                    'Sun',
                  ][index];
                  return FilterChip(
                    label: Text(day),
                    selected: _days.contains(day),
                    onSelected: (bool selected) {
                      setState(() {
                        if (selected) {
                          _days.add(day);
                        } else {
                          _days.remove(day);
                        }
                      });
                    },
                  );
                }).toList(),
              ),
              ListTile(
                title: const Text('Start Time'),
                subtitle: Text(_startTime.format(context)),
                onTap: () async {
                  final time = await showTimePicker(
                    context: context,
                    initialTime: _startTime,
                  );
                  if (time != null) {
                    setState(() {
                      _startTime = time;
                    });
                  }
                },
              ),
              ListTile(
                title: const Text('End Time'),
                subtitle: Text(_endTime.format(context)),
                onTap: () async {
                  final time = await showTimePicker(
                    context: context,
                    initialTime: _endTime,
                  );
                  if (time != null) {
                    setState(() {
                      _endTime = time;
                    });
                  }
                },
              ),
              TextFormField(
                initialValue: _room,
                decoration: const InputDecoration(labelText: 'Location/Room'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a room number.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _room = value!;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Save Course'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
