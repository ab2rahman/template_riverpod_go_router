import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:template_riverpod_go_router/data/data.dart';

final taskRepositoryProvider = Provider<TaskRepository>((ref) {
  final datasource = ref.read(taskDatasourceProvider);
  return TaskRepositoryImpl(datasource);
});
