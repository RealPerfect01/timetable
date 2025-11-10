import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:go_router/go_router.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        PageViewModel(
          title: "Never Miss a Class",
          body: "Easily input and view your complete course schedule.",
          image: const Center(child: Icon(Icons.schedule, size: 100.0)),
        ),
        PageViewModel(
          title: "Deadlines on Autopilot",
          body:
              "Automatic, customizable reminders for assignments, tests, and classes.",
          image: const Center(
            child: Icon(Icons.notifications_active, size: 100.0),
          ),
        ),
        PageViewModel(
          title: "Organize Your Study Life",
          body:
              "All your courses and tasks, persistently saved and easy to manage.",
          image: const Center(child: Icon(Icons.school, size: 100.0)),
        ),
      ],
      onDone: () {
        // When done button is press
        context.go('/signup');
      },
      showSkipButton: true,
      skip: const Text("Skip"),
      next: const Icon(Icons.arrow_forward),
      done: const Text("Done", style: TextStyle(fontWeight: FontWeight.w600)),
    );
  }
}
