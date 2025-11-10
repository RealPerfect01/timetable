import 'package:go_router/go_router.dart';
import '../../features/onboarding/onboarding_screen.dart';
import '../../features/timetable/timetable_screen.dart';
import '../../features/timetable/course_list_screen.dart';
import '../../features/timetable/add_edit_course_screen.dart';
import '../../features/timetable/models/course.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/timetable',
        builder: (context, state) => const TimetableScreen(),
      ),
      GoRoute(
        path: '/courses',
        builder: (context, state) => const CourseListScreen(),
      ),
      GoRoute(
        path: '/add_course',
        builder: (context, state) => const AddEditCourseScreen(),
      ),
      GoRoute(
        path: '/edit_course',
        builder: (context, state) => AddEditCourseScreen(course: state.extra as Course?),
      ),
    ],
  );
}
