import 'package:flutter_riverpod/flutter_riverpod.dart';

final currentIndexState = StateProvider.autoDispose<int>((ref) => 0);