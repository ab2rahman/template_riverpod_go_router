import 'package:flutter/foundation.dart';

@immutable
class RouteLocation {
  const RouteLocation._();

  static String get home => '/home';
  static String get createTask => '/createTask';
  static String get createTaskMultiple => '/createTaskMultiple';
  static String get pokemon => '/pokemon';
}