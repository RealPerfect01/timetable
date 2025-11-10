import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

// Screens
import 'features/onboarding/splash_screen.dart';
import 'features/onboarding/onboarding_screen.dart';
import 'features/onboarding/login_screen.dart';
import 'features/onboarding/signup_screen.dart';
import 'features/timetable/add_edit_course_screen.dart';
import 'features/timetable/course_list_screen.dart';
import 'features/timetable/timetable_screen.dart';
import 'features/timetable/course_details_screen.dart';
import 'features/assignments/assignments_list_screen.dart';
import 'features/settings/settings_screen.dart';

// Providers
import 'features/timetable/providers/courses_provider.dart';
import 'features/timetable/models/course.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => CoursesProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

// ThemeProvider class to manage the theme state
class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  void toggleTheme() {
    _themeMode = _themeMode == ThemeMode.light
        ? ThemeMode.dark
        : ThemeMode.light;
    notifyListeners();
  }
}

// GoRouter configuration
final _router = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(path: '/splash', builder: (context, state) => const SplashScreen()),
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
    GoRoute(path: '/signup', builder: (context, state) => const SignupScreen()),
    GoRoute(path: '/', builder: (context, state) => const TimetableScreen()),
    GoRoute(
      path: '/add_course',
      builder: (context, state) =>
          AddEditCourseScreen(course: state.extra as Course?),
    ),
    GoRoute(
      path: '/courses',
      builder: (context, state) => const CourseListScreen(),
    ),
    GoRoute(
      path: '/course_details',
      builder: (context, state) =>
          CourseDetailsScreen(course: state.extra as Course),
    ),
    GoRoute(
      path: '/assignments',
      builder: (context, state) => const AssignmentsListScreen(),
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsScreen(),
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primarySeedColor = Color(0xFF4A90E2);
    const Color secondaryColor = Color(0xFF7ED321);

    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp.router(
          title: 'Student Timetable',
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              seedColor: primarySeedColor,
              brightness: Brightness.light,
              secondary: secondaryColor,
            ),
            textTheme: GoogleFonts.poppinsTextTheme(
              Theme.of(context).textTheme,
            ),
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          darkTheme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              seedColor: primarySeedColor,
              brightness: Brightness.dark,
              secondary: secondaryColor,
            ),
            textTheme: GoogleFonts.poppinsTextTheme(
              Theme.of(context).primaryTextTheme,
            ),
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          themeMode: themeProvider.themeMode,
          routerConfig: _router,
        );
      },
    );
  }
}
