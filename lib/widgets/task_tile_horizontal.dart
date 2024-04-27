import 'package:flutter/material.dart';
import 'package:template_riverpod_go_router/data/data.dart';
import 'package:template_riverpod_go_router/utils/utils.dart';
import 'package:template_riverpod_go_router/widgets/widgets.dart';
import 'package:gap/gap.dart';

class TaskTileHorizontal extends StatelessWidget {
  const TaskTileHorizontal({
    Key? key,
    required this.task,
    this.onCompleted,
  }) : super(key: key);

  final Task task;
  final Function(bool?)? onCompleted;

  @override
  Widget build(BuildContext context) {
    final style = context.textTheme;
    final colors = context.colorScheme;

    final textDecoration =
        task.isCompleted ? TextDecoration.lineThrough : TextDecoration.none;
    final fontWeight = task.isCompleted ? FontWeight.normal : FontWeight.bold;
    final double iconOpacity = task.isCompleted ? 0.3 : 0.5;
    final double backgroundOpacity = task.isCompleted ? 0.1 : 0.3;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.only(left: 16, top: 10, bottom: 10),
        child: Row(
          children: [
            CircleContainer(
              borderColor: task.category.color,
              color: task.category.color.withOpacity(backgroundOpacity),
              child: Icon(
                task.category.icon,
                color: task.category.color.withOpacity(iconOpacity),
              ),
            ),
            const Gap(16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  task.title,
                  style: style!.titleMedium?.copyWith(
                    fontWeight: fontWeight,
                    fontSize: 20,
                    decoration: textDecoration,
                  ),
                ),
                Text(
                  task.time,
                  style: style.titleMedium?.copyWith(
                    decoration: textDecoration,
                  ),
                ),
              ],
            ),
            const SizedBox(
                width:
                    16), // Add a fixed width SizedBox to separate the Checkbox
            Checkbox(
              value: task.isCompleted,
              onChanged: onCompleted,
              checkColor: colors!.surface,
            ),
          ],
        ),
      ),
    );
  }
}
