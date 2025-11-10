# Project Blueprint

## Overview

This is a Flutter application designed to help students manage their course schedules. It allows them to view their timetable, add, edit, and delete courses, and see upcoming classes.

## Features

* **Onboarding:** A simple onboarding screen to welcome users.
* **Timetable:** A screen to display the user's weekly course schedule.
* **Course Management:** Users can add, edit, and delete their courses.
* **Upcoming Classes:** A widget that displays the upcoming classes for the day.
* **Notifications:** The application can schedule notifications for upcoming classes.

## Style and Design

The application uses the Material Design 3 theme with a purple color scheme. It uses the `google_fonts` package for custom fonts and `provider` for state management.

## Plan and Steps for Current Changes

1.  **Fix data type mismatches:** Corrected all `argument_type_not_assignable` errors by ensuring that `DateTime` and `TimeOfDay` objects are used correctly throughout the application.
2.  **Fix `extra_positional_arguments_could_be_named` error:** Corrected the number of positional arguments in `AndroidNotificationDetails`.
3.  **Fix unused import:** Removed the unused `material.dart` import from `app_router.dart`.
4.  **Update `widget_test.dart`:** Replaced the incomplete test with a simple smoke test.
