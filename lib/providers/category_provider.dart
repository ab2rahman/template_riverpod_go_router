import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:template_riverpod_go_router/utils/utils.dart';

final categoryProvider = StateProvider.autoDispose<TaskCategory>((ref) {
  return TaskCategory.others;
});
