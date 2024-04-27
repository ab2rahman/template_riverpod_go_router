import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:template_riverpod_go_router/configs/route/routes.dart';
import 'package:template_riverpod_go_router/data/data.dart';
import 'package:template_riverpod_go_router/providers/providers.dart';
import 'package:template_riverpod_go_router/utils/utils.dart';
import 'package:template_riverpod_go_router/widgets/widgets.dart';

class CreateTaskMultipleScreen extends ConsumerStatefulWidget {
  static CreateTaskMultipleScreen builder(
    BuildContext context,
    GoRouterState state,
  ) =>
      const CreateTaskMultipleScreen();
  const CreateTaskMultipleScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CreateTaskMultipleScreenState();
}

class _CreateTaskMultipleScreenState
    extends ConsumerState<CreateTaskMultipleScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestionIndex = ref.watch(currentIndexState);
    final colors = context.colorScheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colors.primary,
        title: const DisplayWhiteText(
          text: 'Add New Task',
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: Container()),
            SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  currentQuestionIndex == 0
                      ? CommonTextField(
                          hintText: 'Task Title',
                          title: 'Task Title',
                          controller: _titleController,
                        )
                      : Container(),
                  currentQuestionIndex == 1
                      ? const CategoriesSelection()
                      : Container(),
                  currentQuestionIndex == 2
                      ? const SelectDateTime()
                      : Container(),
                  currentQuestionIndex == 3
                      ? CommonTextField(
                          hintText: 'Notes',
                          title: 'Notes',
                          maxLines: 6,
                          controller: _noteController,
                        )
                      : Container(),
                ],
              ),
            ),
            Expanded(child: Container()),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                currentQuestionIndex > 0
                    ? ElevatedButton(
                        onPressed: () => _prevQuestion(),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: DisplayWhiteText(
                            text: 'Previous',
                          ),
                        ),
                      )
                    : Container(),
                if (currentQuestionIndex > 0) const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () => currentQuestionIndex == 3
                      ? _createTask()
                      : _nextQuestion(),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DisplayWhiteText(
                      text: currentQuestionIndex == 3 ? 'Save' : 'Next',
                    ),
                  ),
                ),
              ],
            ),
            const Gap(30)
          ],
        ),
      ),
    );
  }

  void _prevQuestion() {
    final index = ref.read(currentIndexState.notifier).state;
    ref.read(currentIndexState.notifier).state = index - 1;
    debugPrint(index.toString());
  }

  void _nextQuestion() {
    final index = ref.read(currentIndexState.notifier).state;
    ref.read(currentIndexState.notifier).state = index + 1;
    debugPrint(index.toString());
  }

  void _createTask() async {
    final title = _titleController.text.trim();
    final note = _noteController.text.trim();
    final time = ref.watch(timeProvider);
    final date = ref.watch(dateProvider);
    final category = ref.watch(categoryProvider);
    if (title.isNotEmpty) {
      final task = Task(
        title: title,
        category: category,
        time: Helpers.timeToString(time),
        date: DateFormat.yMMMd().format(date),
        note: note,
        isCompleted: false,
      );

      await ref.read(tasksProvider.notifier).createTask(task).then((value) {
        AppAlerts.displaySnackbar(context, 'Task create successfully');
        context.go(RouteLocation.home);
      });
    } else {
      AppAlerts.displaySnackbar(context, 'Title cannot be empty');
    }
  }
}
