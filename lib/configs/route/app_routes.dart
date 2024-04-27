import 'package:go_router/go_router.dart';
import 'package:template_riverpod_go_router/configs/configs.dart';
import 'package:template_riverpod_go_router/screens/screens.dart';

final appRoutes = [
  GoRoute(
    path: RouteLocation.home,
    parentNavigatorKey: navigationKey,
    builder: HomeScreen.builder,
  ),
  GoRoute(
    path: RouteLocation.createTask,
    parentNavigatorKey: navigationKey,
    builder: CreateTaskScreen.builder,
  ),
];