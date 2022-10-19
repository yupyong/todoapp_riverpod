import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskapp/model/providers.dart';
import 'package:taskapp/model/task.dart';

class AddTaskAlert extends ConsumerWidget {
  late String newTask;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      title: Text('タスクを追加しますか?'),
      actions: <Widget>[
        TextField(
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
                      .watch(taskNotifier.notifier)
                      .addTask(Task(title: newTask));
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
