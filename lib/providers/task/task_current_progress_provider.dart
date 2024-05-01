import 'package:flutter_riverpod/flutter_riverpod.dart';

final currentProgressState = StateProvider.autoDispose<List<bool>>(
    (ref) => [false, false, false, false]);
