import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:template_riverpod_go_router/configs/configs.dart';

class FlutterTemplateRiverpodGoRouterApp extends ConsumerWidget {
  const FlutterTemplateRiverpodGoRouterApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final route = ref.watch(routesProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      routerConfig: route,
    );
  }
}