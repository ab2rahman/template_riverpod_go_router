import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:template_riverpod_go_router/data/datasource/datasource.dart';

final taskDatasourceProvider = Provider<TaskDatasource>((ref) {
  return TaskDatasource();
});
