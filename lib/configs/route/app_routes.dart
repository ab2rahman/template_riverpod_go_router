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
  GoRoute(
    path: RouteLocation.createTaskMultiple,
    parentNavigatorKey: navigationKey,
    builder: CreateTaskMultipleScreen.builder,
  ),
  GoRoute(
    path: RouteLocation.pokemon,
    parentNavigatorKey: navigationKey,
    builder: PokemonScreen.builder,
  ),
  GoRoute(
    path: RouteLocation.chat,
    parentNavigatorKey: navigationKey,
    builder: ChatScreen.builder,
  ),
  GoRoute(
    path: RouteLocation.login,
    parentNavigatorKey: navigationKey,
    builder: LoginScreen.builder,
  ),
];