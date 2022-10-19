import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskapp/screens/add_task_alert.dart';

import '../model/providers.dart';
import '../model/task.dart';

class Listview extends StatelessWidget {
  const Listview({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      var taskCompleted = ref.watch(completeProvider.state).state;
      final editMode = ref.watch(editProvider.state).state;
      final List<Task> tasks = ref.watch(taskNotifier);

      return ReorderableListView(
        header: editMode
            ? GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (_) {
                        return AddTaskAlert();
                      });
                },
                child: ListTile(
                  leading: Icon(Icons.add),
                  title: Text('タスクを追加'),
                ),
              )
            : null,
        footer: editMode
            ? GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (_) {
                        return AddTaskAlert();
                      });
                },
                child: ListTile(
                  key: key,
                  leading: Icon(Icons.add),
                  title: Text('タスクを追加'),
                ),
              )
            : null,
        //nullの値で切り替える2つのListTile
        onReorder: (int oldIndex, int newIndex) {},
        children: [
          for (final task in tasks)
            ListTile(
              key: ValueKey(task),
              title: Text(task.title),
              trailing: editMode
                  ? GestureDetector(
                      onTap: () {
                        ref.watch(taskNotifier.notifier).deleteTask(task.title);
                      },
                      child: Icon(
                        Icons.close,
                        color: Colors.red,
                      ),
                    )
                  : null,
            ),
        ],
      );
    });
  }
}
