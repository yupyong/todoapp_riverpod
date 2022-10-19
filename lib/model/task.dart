import 'package:flutter/material.dart';

@immutable
class Task {
  Task({required this.title, this.isDone = false});

  final String title;
  bool isDone;
}
