import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskapp/model/task.dart';

List<Task> tasks = [
  Task(title: 'buy the milk'),
  Task(title: 'go to the gym'),
  Task(title: 'buy milk'),
];

class TaskNotifier extends StateNotifier<List<Task>> {
  TaskNotifier() : super(tasks);

  void addTask(Task task) {
    state = [...state, task];
  }

  void deleteTask(String title) {
    state = [
      for (final task in state)
        if (task.title != title) task,
    ];
  }
}

final taskNotifier =
    StateNotifierProvider<TaskNotifier, List<Task>>((ref) => TaskNotifier());

final StateProvider<bool> completeProvider =
    StateProvider<bool>((ref) => false);

final StateProvider<bool> editProvider = StateProvider<bool>((ref) => false);
