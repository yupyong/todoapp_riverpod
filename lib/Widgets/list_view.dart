import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskapp/screens/add_task_alert.dart';
import 'package:taskapp/screens/edit_task_alert.dart';

import '../model/providers.dart';
import '../model/task.dart';
import 'add_task_bar.dart';

class Listview extends ConsumerWidget {
  const Listview({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Consumer(builder: (context, ref, _) {
      final editMode = ref.watch(editProvider.state).state;
      final List<Task> tasks = ref.watch(taskNotifier);

      return ReorderableListView(
        header: editMode ? AddTaskBar() : null,
        footer: editMode ? AddTaskBar() : null,
        //nullの値で切り替える2つのListTile
        onReorder: (int oldIndex, int newIndex) {
          ref.watch(taskNotifier.notifier).onReorder(oldIndex, newIndex);
        },
        children: [
          for (final task in tasks)
            editMode
                ? InkWell(
                    key: ValueKey(task),
                    onLongPress: () {
                      showDialog(
                          context: context,
                          builder: (_) {
                            return EditTaskAlert(task.title);
                          });
                    },
                    child: ListTile(
                      //編集モードの時
                      title: Text(task.title),
                      trailing: GestureDetector(
                          onTap: () {
                            ref
                                .watch(taskNotifier.notifier)
                                .deleteTask(task.title);
                          },
                          child: Icon(
                            Icons.close,
                            color: Colors.red,
                          )),
                    ),
                  )
                : GestureDetector(
                    key: ValueKey(task),
                    onTap: () {
                      ref.read(taskNotifier.notifier).toggle(task.id);
                    },
                    child: ListTile(
                      title: task.isDone
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  task.title,
                                  style: TextStyle(
                                      decoration: TextDecoration.lineThrough),
                                ),
                                Icon(
                                  Icons.check,
                                  color: Colors.green,
                                )
                              ],
                            )
                          : Text(task.title),
                    ),
                  ),
        ],
      );
    });
  }
}
