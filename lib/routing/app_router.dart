
import 'package:go_router/go_router.dart';
import '../features/home/home_screen.dart';
import '../features/onboarding/splash_screen.dart';
import '../features/onboarding/onboarding_screen.dart';
import '../features/onboarding/login_screen.dart';
import '../features/onboarding/signup_screen.dart';
import '../features/timetable/course_list_screen.dart';
import '../features/timetable/add_edit_course_screen.dart';
import '../features/assignments/assignments_list_screen.dart';
import '../features/tests/tests_screen.dart';
import '../features/notifications/notifications_screen.dart';
import '../features/profile/profile_screen.dart';
import '../features/settings/settings_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/signup',
      builder: (context, state) => const SignupScreen(),
    ),
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
      routes: [
        GoRoute(
          path: 'courses',
          builder: (context, state) => const CourseListScreen(),
        ),
        GoRoute(
          path: 'add_course',
          builder: (context, state) => const AddEditCourseScreen(),
        ),
        GoRoute(
          path: 'edit_course/:id',
          builder: (context, state) => AddEditCourseScreen(
            course: state.extra as dynamic,
          ),
        ),
        GoRoute(
          path: 'assignments',
          builder: (context, state) => const AssignmentsListScreen(),
        ),
        GoRoute(
          path: 'tests',
          builder: (context, state) => const TestsScreen(),
        ),
        GoRoute(
          path: 'notifications',
          builder: (context, state) => const NotificationsScreen(),
        ),
        GoRoute(
          path: 'profile',
          builder: (context, state) => const ProfileScreen(),
        ),
        GoRoute(
          path: 'settings',
          builder: (context, state) => const SettingsScreen(),
        ),
      ],
    ),
  ],
);
