import 'package:flutter/material.dart';

@immutable
class Task {
  Task({required this.id, required this.title, this.isDone = false});

  final String title;
  final bool isDone;
  final int id;

  Task copyWith({int? id, String? title, bool? isDone}) {
    return Task(
        id: id ?? this.id,
        title: title ?? this.title,
        isDone: isDone ?? this.isDone);
  }
}
