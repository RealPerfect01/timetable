import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';
import '../models/course.dart';

Future<void> exportToExcel(BuildContext context, List<Course> courses) async {
  if (courses.isEmpty) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('No courses to export.')));
    return;
  }

  // Create a new Excel document.
  final Workbook workbook = Workbook();
  final Worksheet sheet = workbook.worksheets[0];

  // Add headers.
  sheet.getRangeByName('A1').setText('Course Name');
  sheet.getRangeByName('B1').setText('Course Code');
  sheet.getRangeByName('C1').setText('Instructor');
  sheet.getRangeByName('D1').setText('Days');
  sheet.getRangeByName('E1').setText('Start Time');
  sheet.getRangeByName('F1').setText('End Time');
  sheet.getRangeByName('G1').setText('Location');

  // Add data.
  for (int i = 0; i < courses.length; i++) {
    final Course course = courses[i];
    sheet.getRangeByName('A${i + 2}').setText(course.courseName);
    sheet.getRangeByName('B${i + 2}').setText(course.courseCode);
    sheet.getRangeByName('C${i + 2}').setText(course.instructor);
    sheet.getRangeByName('D${i + 2}').setText(course.days.join(', '));
    sheet.getRangeByName('E${i + 2}').setText(course.startTime.format(context));
    sheet.getRangeByName('F${i + 2}').setText(course.endTime.format(context));
    sheet.getRangeByName('G${i + 2}').setText(course.room);
  }

  // Save the document.
  final List<int> bytes = workbook.saveAsStream();
  workbook.dispose();

  // Get the path to the directory where the file will be saved.
  final Directory directory = await getApplicationDocumentsDirectory();
  final String path = directory.path;
  final String fileName = '$path/StudentTimetable.xlsx';
  final File file = File(fileName);
  await file.writeAsBytes(bytes, flush: true);

  // Open the saved file.
  if (!context.mounted) return;
  final OpenResult result = await OpenFile.open(fileName);

  if (result.type != ResultType.done) {
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Could not open the file: ${result.message}')),
    );
  }
}
