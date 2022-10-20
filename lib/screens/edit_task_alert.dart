import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskapp/model/providers.dart';
import 'package:taskapp/model/task.dart';

class EditTaskAlert extends ConsumerWidget {
  EditTaskAlert(this.taskText, {Key? key}) : super(key: key);
  late String newTask;
  late String taskText;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Task> tasks = ref.watch(taskNotifier);
      return AlertDialog(
        title: Text('タスクを編集しますか?'),
        actions: <Widget>[
            TextFormField(
              initialValue: taskText,
              textAlign: TextAlign.center,
              onChanged: (value) {
                newTask = value;
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'いいえ',
                      style: TextStyle(color: Colors.green),
                    )),
                TextButton(
                    onPressed: () {
                      ref
                          .read(taskNotifier.notifier)
                          .editingTask(,newTask);
                      Navigator.pop(context);
                    },
                    child: Text(
                      'OK',
                      style: TextStyle(color: Colors.green),
                    )),
              ],
            ),
        ],
      );
  }
}
