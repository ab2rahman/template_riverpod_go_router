import 'package:equatable/equatable.dart';
import 'package:template_riverpod_go_router/data/data.dart';

class TaskState extends Equatable {
  final List<Task> tasks;

  const TaskState({
    required this.tasks,
  });
  const TaskState.initial({
    this.tasks = const [],
  });

  TaskState copyWith({
    List<Task>? tasks,
  }) {
    return TaskState(
      tasks: tasks ?? this.tasks,
    );
  }

  @override
  List<Object> get props => [tasks];
}