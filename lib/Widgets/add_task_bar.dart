import 'package:flutter/material.dart';

import '../screens/add_task_screen.dart';

class AddTaskBar extends StatelessWidget {
  const AddTaskBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
    );
  }
}
