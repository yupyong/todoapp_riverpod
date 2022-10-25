import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskapp/model/task.dart';

List<Task> tasks = [];

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

  void toggle(int id) {
    List<Task> newState = [];
    for (final tasks in state) {
      if (tasks.id == id) {
        newState.add(tasks.copyWith(isDone: !tasks.isDone));
      } else {
        newState.add(tasks);
      }
    }
    state = newState;
  }

  void editingTask(int id, String newText) {
    List<Task> newTask = [];
    for (final tasks in state) {
      if (tasks.id == id) {
        newTask.add(tasks.copyWith(title: newText));
      } else {
        newTask.add(tasks);
      }
      state = newTask;
    }
  }

  void onReorder(int oldIndex, int newIndex) {
    List<Task> newTask = [];
    for (final tasks in state) {
      newTask.add(tasks);
    }
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final Task task = newTask.removeAt(oldIndex);
    newTask.insert(newIndex, task);
    state = newTask;
  }
}

final taskNotifier =
    StateNotifierProvider<TaskNotifier, List<Task>>((ref) => TaskNotifier());

final StateProvider<bool> completeProvider =
    StateProvider<bool>((ref) => false);

final StateProvider<bool> editProvider = StateProvider<bool>((ref) => false);
