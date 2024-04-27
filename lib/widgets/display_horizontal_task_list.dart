import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:template_riverpod_go_router/data/data.dart';
import 'package:template_riverpod_go_router/providers/providers.dart';
import 'package:template_riverpod_go_router/utils/utils.dart';
import 'package:template_riverpod_go_router/widgets/widgets.dart';

class DisplayHorizontalTaskList extends ConsumerWidget {
  const DisplayHorizontalTaskList({
    Key? key,
    this.isCompletedTasks = false,
    required this.tasks,
  }) : super(key: key);
  final bool isCompletedTasks;
  final List<Task> tasks;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CommonContainer(
      height: 150, // Adjust the height as needed
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: tasks.map((task) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TaskTileHorizontal(
              task: task,
              onCompleted: (value) async {
                await ref
                    .read(tasksProvider.notifier)
                    .updateTask(task)
                    .then((value) {
                  AppAlerts.displaySnackbar(
                    context,
                    task.isCompleted ? 'Task incompleted' : 'Task completed',
                  );
                });
              },
            ),
          );
        }).toList(),
      ),
    );
  }
}
