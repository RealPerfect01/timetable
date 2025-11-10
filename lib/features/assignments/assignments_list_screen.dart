import 'package:flutter/material.dart';

class AssignmentsListScreen extends StatelessWidget {
  const AssignmentsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Assignments')),
      body: const Center(child: Text('Assignments List Screen')),
    );
  }
}
